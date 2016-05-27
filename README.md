# Medea

[![license](https://img.shields.io/github/license/swiftmedea/medea.svg?maxAge=2592000)](https://raw.githubusercontent.com/SwiftMedea/Medea/master/LICENSE)
[![Code Climate](https://codeclimate.com/github/SwiftMedea/Medea/badges/gpa.svg)](https://codeclimate.com/github/SwiftMedea/Medea)
[![Issue Count](https://codeclimate.com/github/SwiftMedea/Medea/badges/issue_count.svg)](https://codeclimate.com/github/SwiftMedea/Medea)
[![Travis CI](https://travis-ci.org/SwiftMedea/Medea.svg?branch=master)](https://travis-ci.org/SwiftMedea/Medea)

There is a plenty of JSON libraries for Swift already.  Why this one?

- It is using pure Swift and only Swift. It will work anywhere Swift works.  Foundation is not necessary.
- It is using strong Swift type system by using enums. No more guessing around AnyObject.
- It provides convenient subcript access to nested JSON sub-components.
- It comes with flatten() method that shows how exactly to get to any particular value. 
- It promotes encapsulation with JSONEncodable and JSONDecodable protocols that allow any of your types to be easily (de-)serialized to/from JSON.

This library was inspired by three other Swift libraries that facilitate JSON, namely [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON), [Gloss](https://github.com/hkellaway/Gloss) and [TidyJSON](https://github.com/benloong/TidyJSON).

## Contents

- [Usage](#usage)
  - [Literals](#literals)
  - [Initializers](#initializers)
  - [Unwrapping](#unwrapping)
  - [Subscripting](#subscripting) 
  - [Coercing](#coercing)
  - [Encoding](#encoding)
  - [Decoding](#decoding)
  - [Iterating](#iterating) 
  - [Flattening](#flattening)
  - [Error handling](#error-handling)
  - [Converting from/to Foundation JSON](#converting-fromto-foundation-json)

## Usage

The core of `Medea` framework is `JSON` type.  In practice it's just an `enum` like:
````swift
enum JSON {
    case Null
    case Boolean(Bool)
    case Integer(Int)
    case Float(Double)
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
let floatJSON: JSON = 36.6
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

if let float = arrayJSON[2].unwrappedFloat {
    print(float) // Prints "2.0"
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
arrayJSON.forEach {
    (index: JSONIndex, json: JSON) in

    print(index, json)
}

// Above snippet prints:
//
// [0] false
// [1] 1
// [2] 2.0
// [3] "3"
````

`JSONIndex` is a special type that can accomodate both the position of an element in JSON array, and the name of a property in JSON object.

## Flattening

Moreover, there is a special method `flatten()` that comes very handy when working with complex `JSON` structures.  It flattens all container JSON values (that is, `.Object` and `.Array`) into an array of tuples `(path: JSONPath, json: JSON)`, where `path` will indicate a path that has to be traversed in order to get to every basic `JSON` sub-element.
 
For example:

````swift
jsonBook.flatten().forEach {
    (path: JSONPath, json: JSON) in

    print("jsonBook\(path) == \(json)")
}

// Above snippet prints:
//
// jsonBook["title"] == "Dune"
// jsonBook["isPaperback"] == true
// jsonBook["authors"][0] == "Frank Herbert"
// jsonBook["notes"]["series"] == "Dune"
// jsonBook["notes"]["seriesNo"] == "1"
// jsonBook["pages"] == 896
````

So, no more fumbling in the darkness about how to get to the certain element of a branchy JSON tree.  Just do something like above and simply copy-paste the path like follows:

````swift
print(jsonBook["authors"][0]) // Prints "Frank Herbert"
````

### Error handling

You have probably noticed that some initializers or methods use `try!` signature.  This is because firstly, not every string can be deserialized in a `JSON`, and secondly, not every `JSON` can be translated into the desired destination type.  All errors that can occur during deserialization/decoding are grouped under `JSON.Error` structure.  There are three of them:

- `JSON.Error.Deserializing`
- `JSON.Error.Decoding`
- `JSON.Error.Converting`
- `JSON.Error.Subscripting`

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
