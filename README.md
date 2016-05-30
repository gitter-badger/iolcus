# Medea

[![license](https://img.shields.io/github/license/swiftmedea/medea.svg?maxAge=2592000)](https://raw.githubusercontent.com/SwiftMedea/Medea/master/LICENSE)
[![Code Climate](https://codeclimate.com/github/SwiftMedea/Medea/badges/gpa.svg)](https://codeclimate.com/github/SwiftMedea/Medea)
[![Issue Count](https://codeclimate.com/github/SwiftMedea/Medea/badges/issue_count.svg)](https://codeclimate.com/github/SwiftMedea/Medea)
[![Travis CI](https://travis-ci.org/SwiftMedea/Medea.svg?branch=master)](https://travis-ci.org/SwiftMedea/Medea)

There is a plenty of JSON libraries for Swift already.  Why this one?

- It is using pure Swift and only Swift. It will work anywhere Swift works.  Even `Foundation` framework is not necessary.
- It enforces strict type system by using `enum` to wrap each possible case of JSON.  So, no more need to resort to obscure `AnyObject`.
- It takes convenience of use and readability of code seriously.  For example, it provides convenient subcript access to nested JSON sub-components.  Encoding and decoding of custom types to/from JSON is easy and transparent.  Quite few feactures come out-of-the-box via default protocol implementations, etc.

This library was inspired by [`SwiftyJSON`](https://github.com/SwiftyJSON/SwiftyJSON), [`Gloss`](https://github.com/hkellaway/Gloss) and [`TidyJSON`](https://github.com/benloong/TidyJSON).

## Contents

- [Usage](#usage)
  - [Literals](#literals)
  - [Initializers](#initializers)
  - [Inspecting](#inspecting)
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

The core of `Medea` framework is `JSON` type.  In practice it's just an `enum`:
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

It's possible to create an instance of `JSON` by just assigning a property with some literal:
  
````swift
import Medea

let jsonBoolean: JSON = true
let jsonInteger: JSON = 42
let jsonFloat: JSON = 36.6
let jsonString: JSON = "Lorem ipsum dolor sit amet"
var jsonArray: JSON = [false, 1, 42.0, "3"]
var jsonObject: JSON = [
    "boolean" : false,
    "integer" : -42,
    "string"  : "Lorem ipsum"
]
````
 
### Initializers
 
Some other ways ways to instantiate `JSON` are:
 
````swift
// Direcly via enum's case
let jsonAnotherInteger = JSON.Integer(99)

// By encoding JSON from an instance conforming to JSONEncodable protocol
let jsonAnotherBoolean = JSON(encoding: true)

// By copying another JSON's sub-element
let jsonAnotherFloat = try! JSON(json: jsonArray, at: 2)                    // 42.0
let jsonAnotherString = try! JSON(json: jsonObject, at: "string")           // "Lorem ipsum"

// By deserializing string representation of JSON
let jsonAnotherArray = try! JSON(serialization: "[false, 1, 2.0, \"3\"]")   // [false, 1, 2.0, "3"]
````

### Inspecting

Although, `JSON` is `enum` and as such can be inspected via standard Swift `switch` pattern, or via `if case`, it is eaiser to just use the set of computed properties `isNull`, `isBoolean`, `isInteger`, etc.  For example:

````swift
if jsonFloat.isNumber {
    print("\(jsonFloat) is a number") // Yes, it is
}
````

### Unwrapping
 
Every `JSON` value, except `.Null`, wraps either some elementary value (`Bool`, `Int`, `Double` or `String`), or a container (`[JSON]` or `[String: JSON]`).  It is possible to access the value wrapped by `JSON` via special set of computed properties `unwrappedBoolean`, `unwrappedInteger`, etc.

For example:
  
````swift
if let boolean = jsonBoolean.unwrappedBoolean {
    print(boolean.dynamicType) // Bool
    print(boolean)             // true
}
````

... or:
  
````swift
if let dictionaryProperties = jsonObject.unwrappedObject {
    print(dictionaryProperties.dynamicType) // Dictionary<String, JSON>
    print(dictionaryProperties)             // ["integer": -42, "boolean": false, "string": "Lorem ipsum"]
}
````

### Subscripting
 
Elements of the container `JSON` kinds (that is, `.Array` and `.Object`) can be directly reached via subscripts:
  
````swift
let jsonSubElement1 = jsonObject["integer"]     // .Integer(-42)
let jsonSubElement2 = jsonArray[2]              // .Float(42.0)
````

Subscripts can be chained:
````swift
let jsonSubSubElement = jsonObject["array"][3]  // .String("3")
````

### Coercing
  
Just like with unrwapping, there is a set of computed properties `coercedXXX` that help with automatic coercion between elementary `JSON` types.  For example, if you get JSON that has all values passed as strings, although what you really expect can be a number or boolean, you can try to coerce the input:
  
````swift
let jsonStringInteger: JSON = "365" // .String("365")

if let integer = jsonStringInteger.coercedInteger {
    print(integer.dynamicType) // Int
    print(integer)             // 365
}
````

### Encoding

Encoding of a custom type into `JSON` is enabled by implementing `JSONEncodable` protocol.

For example, if we have a structure called `Book`:
 
````swift
struct Book {
    let title       : String
    let pagesCount  : Int
    let isPaperback : Bool
    let authors     : [String]
    let notes       : [String: String]
}
````

... then it could implement `JSONEncodable` as follows:
 
````swift
extension Book: JSONEncodable {
    func jsonEncoded() -> JSON {
        return [
            "title"       : title,
            "pages"       : pagesCount,
            "isPaperback" : isPaperback,
            "authors"     : JSON(encoding: authors),
            "notes"       : JSON(encoding: notes)
        ]
    }
}
````

- note: Array `authors` and dictionary `notes` have to be explicitly encoded into `JSON` via `JSON(encoding: _)` initializer.  This is because there is no support (yet) for conditional protocol conformance by generics.  It [might happen in Swift 3](https://lists.swift.org/pipermail/swift-evolution/Week-of-Mon-20160229/011666.html), though.

Obvioulsy, with `JSONEncodable` implemented, we can encode `Book` instances into `JSON` by calling the method we just implemented:
 
````swift
let book = Book(
    title       : "Dune",
    pagesCount  : 896,
    isPaperback : true,
    authors     : ["Frank Herbert"],
    notes       : [
        "2015-05-23": "The book was slightly damaged. Handed over to repair.",
        "2015-06-10": "Repaired.  Condition is good."
    ]
)

let jsonBook = book.jsonEncoded()

print(jsonBook)

// {
//     "title": "Dune",
//     "isPaperback": true,
//     "authors": [
//         "Frank Herbert"
//     ],
//     "notes": {
//         "2015-05-23": "The book was slightly damaged. Handed over to repair.",
//         "2015-06-10": "Repaired.  Condition is good."
//     },
//     "pages": 896
// }
````
 
... or alternatively we can use the initializer:
 
````swift
let jsonBook2 = JSON(encoding: book)
````

Possibility to encode arrays and dictionaries containing `Book` is available now as well:

````swift
struct Library: JSONEncodable {
    let books: [Book]
    let favorites: [String: Book]
    let series: [String: [Book]]
    func jsonEncoded() -> JSON {
        return [
            "books"     : JSON(encoding: books),
            "favorites" : JSON(encoding: favorites),
            "series"    : JSON(encoding: series)
        ]
    }
}
````

### Serializing / Deserializing
 
With `JSONEncodable` protovol implemented, serialization of instances into JSON strings comes out of the box:
 
````swift
let serializedBook = book.jsonSerialized()
let prettySerializedBook = book.jsonSerialized(prettyPrint: true)
````

Deserializing JSON from the string is also quite simple:
 
````swift
let jsonDeserialized = try! JSON(serialization: serializedBook)
````

Technically, an input string can be not a valid JSON, or not JSON at all.  That's why `JSON(serialization: _)` call can throw.  Errors that can happen are nested under `JSON.Error.Deserializing` type.  Therefore, proper deserialization of of JSON can look like follows:
 
````swift
do {
    let jsonDeserialized2 = try JSON(serialization: prettySerializedBook)
}
catch let error as JSON.Error.Deserializing {
    // Deserializing JSON failed.  Do something about it.
}
````

### Decoding

Similarly to `JSON` encoding, decoding is also made possible via protocol implementation.  In this case it's `JSONDecodable` protocol.  Keeping up with our `Book` as an example:

````swift
extension Book: JSONDecodable {
    init(json: JSON) throws {
        title       = try json.decode(at: "title")
        pagesCount  = try json.decode(at: "pages")
        isPaperback = try json.decode(at: "isPaperback")
        authors     = try json.decode(at: "authors")
        notes       = try json.decode(at: "notes")
    }
}
````

Same thing for `Library`:

````swift
extension Library: JSONDecodable {
    init(json: JSON) throws {
        books     = try json.decode(at: "books")
        favorites = try json.decode(at: "favorites")
        series    = try json.decode(at: "series")
    }
}
````

````swift
As soon as `JSONDecodable` is implemented, decoding of a new instance from `JSON` takes just a call of the initializer that have been implemented:
````

... but deserialization of a `Book` also becomes possible via another initiailizer that is provided by the framework:

````swift
do {
    let yetAnotherBook = try Book(serialization: serializedBook)
}
catch let error as JSON.Error.Deserializing {
    // Something went wrong during deserialization of JSON from input string
}
catch let error as JSON.Error.Decoding {
    // Something went wrong while decoding of JSON into target type
}
catch let error as JSON.Error.Subscripting {
    // Something went wrong while reading values from container JSON elements
}
````

### Iterating
 
Container `JSON` kinds (`.Object` and `.Array`) can be iterated through with usual `for/in` loop or `forEach()` method:
 
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

Non-container `JSON` kinds will accept that as well, although there will be just one iteration made.

- note: `JSONIndex` is `enum` with three cases: `.This` (used for non-container `JSON`), `.Index(Int)` (used for `.Array`) and `.Key(String)` (used for `.Object`).

Naturally, `map()`, `filter()` and all other methods applicable to sequences can be used on `JSON` too:

````swift
let pagerCountIndex = jsonBook.filter {
    $1 == 896
}.first!.index

print(pagerCountIndex) // ["pages"]
````

## Flattening complex `JSON` tree

There is a special method `flatten()` that comes very handy when working with complex `JSON` structures.  It flattens all container JSON values (that is, `.Object` and `.Array`) into an array of tuples `(path: JSONPath, json: JSON)`, where `path` will indicate a path that has to be traversed in order to get to every basic `JSON` sub-element.

For example:

````swift
jsonBook.flatten().forEach {
    (path: JSONPath, json: JSON) in

    print("jsonBook\(path) == \(json)")
}

// jsonBook["title"] == "Dune"
// jsonBook["isPaperback"] == true
// jsonBook["authors"][0] == "Frank Herbert"
// jsonBook["notes"]["series"] == "Dune"
// jsonBook["notes"]["seriesNo"] == "1"
// jsonBook["pages"] == 896
````

And again, we even can use `filter()` method:

````swift
let pathToRepairNote = jsonBook.flatten().filter {
    $1 == "The book was slightly damaged. Handed over to repair."
}.first!.path

print(pathToRepairNote) // ["notes"]["2015-05-23"]
````
