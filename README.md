# Medea

[![Travis CI](https://travis-ci.org/SwiftMedea/Medea.svg?branch=master)](https://travis-ci.org/SwiftMedea/Medea)

- [Usage](#usage)
  - [Literals](#literals)
  - [Initializers](#initializers)
  - [Unwrapping](#unwrapping)
  - [Subscripting](#subscripting) 
  - [Coercing](#coercing)
  - [Encoding](#encoding)
  - [Decoding](#decoding)
  - [Iterating](#iterating)
  - [Error handling](#error-handling)
  - [Converting from/to Foundation JSON](#converting-fromto-foundation-json)

## Usage

The core of `Medea` framework is `JSON` type.  In practice it's just an `enum` like:
````swift
enum JSON {
    case Null
    case Boolean(Bool)
    case Integer(Int)
    case Double(Double)
    case String(String )
    case Array([JSON])
    case Object([String: JSON])
}
````
 
### Literals
 
It's possible to create an instance of `JSON` by just assigning a variable with literal value:
  
````swift
import Medea

let booleanJSON: JSON = true
let integerJSON: JSON = 42
let doubleJSON: JSON = 36.6
let stringJSON: JSON = "Lorem ipsum dolor sit amet"
var arrayJSON: JSON = [false, 1, 2.0, "3"]
var objectJSON: JSON = [
    "boolean" : true,
    "integer" : integerJSON,
    "string"  : "Lorem ipsum",
    "array"   : arrayJSON
]
````
 
### Initializers
 
Alternative ways to instantiate `JSON`:
 
````swift
let anotherIntegerJSON = JSON.Integer(99)
let anotherBooleanJSON = JSON(encodable: true)
let anotherStringJSON = try! JSON(json: objectJSON, at: "string")
let anotherArrayJSON = try! JSON(serialization: "[false, 1, 2.0, \"3\"]")
````

### Unwrapping
 
Every `JSON` value (except `.Null`) is a wrapper around some basic value (`Bool`, `Int`, `Double`, `String`) or around a container (`[JSON]` or `[String: JSON]`).  It is possible to access a particular kind of wrapped instance via dedicated optional property.  For example:
  
````swift
if let boolean = booleanJSON.unwrappedBoolean {
    print(boolean) // Prints "true"
}
````

... or:
  
````swift
if let properties = objectJSON.unwrappedObject {
    if let string = properties["string"]?.unwrappedString {
        print(string) // Prints "Lorem ipsum"
    }
}
````

### Subscripting
 
Elements in an array and object `JSON` kinds can be reached via subscripts:
  
````swift
if let integer = objectJSON["integer"].unwrappedInteger {
    print(integer) // Prints "42"
}

if let double = arrayJSON[2].unwrappedDouble {
    print(double) // Prints "2.0"
}

if let string = objectJSON["array"][3].unwrappedString {
    print(string) // Prints "3"
}
````

### Coercing
  
Sometimes JSON messages come serialized as a pile strings for just everything: boolean, integer, float, whatever.  This is when coercion could be handy.  E.g.:
  
````swift
let something: JSON = "365"

if let integer = something.coercedInteger {
    print(integer) // Prints "365"
}
````

### Encoding

If you want to encode/serialize some type into `JSON` then it will suffice to just adopt `JSONEncodable` protocol.  Let say we have a `Book` type:
 
````swift
struct Book {
    let title       : String
    let pages       : Int
    let isPaperback : Bool
    let authors     : [String]
    let notes       : [String: String]
}

let book = Book(
    title       : "Dune",
    pages       : 896,
    isPaperback : true,
    authors     : ["Frank Herbert"],
    notes       : ["series": "Dune", "seriesNo": "1"]
)
````

Then we could implement `JSONEncodable` protocol like this:
 
````swift
extension Book: JSONEncodable {
    func jsonEncoded() -> JSON {
        let jsonBook: JSON = [
            "title"       : title,
            "pages"       : pages,
            "isPaperback" : isPaperback,
            "authors"     : JSON(encodable: authors),
            "notes"       : JSON(encodable: notes)
        ]
        return jsonBook
    }
}
````

Now this is done we can convert `Book` instances into `JSON` like this:
 
````swift
let jsonBook = book.jsonEncoded()
let anotherJSONBook = JSON(encodable: book)
let arrayOfJSONBooks = JSON(encodable: [book, book, book])
````
 
Moreover, we can now serialize `Book` instances like:
 
````swift
let serializedBook = book.jsonSerialized()
let serializedArray = [book, book, book].jsonSerialized()
````

### Decoding
 
Reverse task, that is decoding/deserializing an instance from `JSON` requires `JSONDecodable` protocol implemented.  For example:
 
````swift
extension Book: JSONDecodable {
    init(json: JSON) throws {
        title       = try json.decode(at: "title")
        pages       = try json.decode(at: "pages")
        isPaperback = try json.decode(at: "isPaperback")
        authors     = try json.decode(at: "authors")
        notes       = try json.decode(at: "notes")
    }
}
````

With this protocol, creating a new instance from `JSON` takes just:
 
````swift
let anotherBook = try! Book(json: jsonBook)
````

... and deserializing a JSON string is done with:
 
````swift
let yetAnotherBook = try! Book(serialization: serializedBook)
````

### Iterating
 
Container `JSON` (object and array) can be looped through:
 
````swift
arrayJSON.forEach() {
    print($0, $1) // $0 is `JSONIndex` and `$1` is child-node of `JSON`
}

for (key, node) in objectJSON {
    print(key, node)
}
````

### Error handling

You have probably noticed that some initializers or methods use `try!` signature.  This is because firstly, not every string can be deserialized in a `JSON`, and secondly, not every `JSON` can be translated into the desired destination type.  All errors that can occur during deserialization/decoding are grouped under `JSON.Error` structure.  There are three of them:

- `JSON.Error.Deserializing`
- `JSON.Error.Decoding`
- `jSON.Error.Converting`

### Converting from/to Foundation JSON

Stadard library provides `NSJSONSerialization` class that has (de-)serialization API (serialization is not yet working in Swift 2, though).  This class uses Foundation's' hierarchy of types to represent JSON instances (namely `NSNull`, `NSNumber`, `NSString`, `NSArray` and `NSDictionary`).  Medea can convert to/from Foundation JSON representation like follows:

````swift
let jsonAnyObject = JSONSerialization.makeAnyObject(json: jsonBook)
let convertedJSON = try! JSONDeserialization.makeJSON(jsonAnyObject: jsonAnyObject)
````

It's even possible to instantiate an instance of `JSONDecodable` type from Foundation's JSON:

````swift
let ohNoNotThatBookAgain = try! Book(jsonAnyObject: jsonAnyObject)
````
