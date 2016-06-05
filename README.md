# Iolcus

[![license](https://img.shields.io/github/license/iolcus/iolcus.svg?maxAge=2592000)](https://raw.githubusercontent.com/iolcus/iolcus/master/LICENSE)
[![Code Climate](https://codeclimate.com/github/iolcus/iolcus/badges/gpa.svg)](https://codeclimate.com/github/iolcus/iolcus)
[![Issue Count](https://codeclimate.com/github/iolcus/iolcus/badges/issue_count.svg)](https://codeclimate.com/github/iolcus/iolcus)
[![Travis CI](https://travis-ci.org/iolcus/iolcus.svg?branch=master)](https://travis-ci.org/iolcus/iolcus)

There is a plenty of JSON libraries for Swift already.  Why this one?

- It is using pure Swift and only Swift. It will work anywhere Swift works.  Even `Foundation` framework is not necessary.
- It enforces strict types conformance by wrapping each possible case of JSON in `enum`.  Therefore, no more need to resort to obscure `AnyObject`.
- It takes convenience and readability quite seriously.  In particular, it provides subcript access to nested JSON sub-components, easy encoding and decoding of custom types, out-of-the-box serialization for the types that adopted encoding protocols, etc.

This library was inspired by [`SwiftyJSON`](https://github.com/SwiftyJSON/SwiftyJSON), [`Gloss`](https://github.com/hkellaway/Gloss) and [`TidyJSON`](https://github.com/benloong/TidyJSON).

## Contents

- [Usage](#usage)
  - [`JSON` literals](#json-literals)
  - [`JSON` initializers](#json-initializers)
  - [Inspecting `JSON`](#inspecting-json)
  - [Unwrapping and coercing `JSON` values](#unwrapping-and-coercing-json-values)
  - [Subscripting](#subscripting) 
  - [Encoding](#encoding)
  - [Decoding](#decoding)
  - [Serializing and deserializing](#serializing-and-deserializing) 
  - [Iterating over `JSON`](#iterating-over-json)

## Usage

The core of `Iolcus` framework is `JSON` type.  In practice it's just an `enum`:

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

### `JSON` literals

It's possible to create an instance of `JSON` by just assigning some property with a literal:
  
````swift
import Iolcus

let jsonBoolean: JSON = true
let jsonInteger: JSON = 42
let jsonFloat: JSON = 36.6
let jsonString: JSON = "Lorem ipsum dolor sit amet"
let jsonArray: JSON = [false, 1, 42.0, "3"]
let jsonObject: JSON = [
    "boolean" : false,
    "integer" : -42,
    "string"  : "Lorem ipsum"
]
````
 
### `JSON` initializers

Some other ways ways to instantiate `JSON` are:
 
````swift
// Direcly via enum's case
let jsonLUAE = JSON.Integer(42)

// By encoding JSON from an JSONEncodable-conforming instance
let jsonNotFalse = JSON(encoding: true)

// By copying another JSON's sub-element
let jsonSentence: JSON = ["Lorem", "ipsum", "dolor", "sit", "amet"]
let jsonFirstWord = try! JSON(json: jsonSentence, at: 0)    // .String("Lorem")

let jsonPerson: JSON = ["name": "John Doe", "age": 42]
let jsonAge = try! JSON(json: jsonPerson, at: "age")        // .Integer(42)

// By deserializing string representation of JSON
let serializedFibonacci = "[1, 1, 2, 3, 5, 8]"
let jsonFibonacci = try! JSON(jsonSerialization: serializedFibonacci)
````

### Inspecting `JSON`

Although, `JSON` is `enum` and as such can be used in standard Swift `switch` statement, or in `if/case` pattern, it might be eaiser to use the set of `is...`  (`isNull`, `isBoolean`, `isInteger`,  etc) computed properties to check which particular `JSON` kind is being handled at the moment.

For example:

````swift
let jsonStuff: JSON = [true, "Ook", 36.6, 999, "Eek"]       // Prints:
//
for (_, element) in jsonStuff where element.isNumber {      // Float 36.6
    print(element.kind, element)                            // Integer 999
}
````

### Unwrapping and coercing `JSON` values

Every `JSON` value, except `.Null`, wraps either some elementary value (`Bool`, `Int`, `Double` or `String`) or a container (`[JSON]` or `[String: JSON]`).  It is possible to access the value wrapped by `JSON` via special set of computed properties `unwrapped...` (`unwrappedBoolean`, `unwrappedInteger`, `unwrappedFloat` , etc).  These properties return either a wrapped value (if the type matches) or `nil` (if there is no match).

For example:
  
````swift
let jsonEarth: JSON = [
    "isFlat" : false,
    "mass"   : JSON(encoding: ["value": 5.972e24, "uom": "kg"]),
    "radius" : JSON(encoding: ["value": 6371, "uom": "km"])
]

if let earthIsFlat = jsonEarth["isFlat"].unwrappedBoolean {         // Prints:
    if !earthIsFlat {                                               //
        print("Earth is not flat")                                  // Earth is not flat
    }
}

if let earthMass = jsonEarth["mass"]["value"].unwrappedString {     // Prints nothing because
    print("Earth's mass is \(earthMass)")                           // unwrappedString returns nil
}                                                                   // for JSON.Float values
````

In addition to `unwrapped...` set of properties there is another set of `coerced...` properties.  This set provides implicit conversion from actually wrapped elementary value into a target type.  If such conversion is not possible then the result is, again, `nil`.

For example:
  
````swift
if let earthMass = jsonEarth["mass"]["value"].coercedString {       // Prints:
    print("Earth's mass is \(earthMass)")                           //
}                                                                   // Earth's mass is 5.972e+24
````

### Subscripting
 
Elements of the container `JSON` kinds (that is, `.Array` and `.Object`) can be directly accessed via subscripts:
  
````swift
let jsonEarthIsFlat = jsonEarth["isFlat"]       // .Boolean(false)
````

Subscripts can be chained:

````swift
let jsonEarthMass = jsonEarth["mass"]["value"]  // .Float(5.972e+24)
````

Subscripts can be used as setters:

````swift
var jsonListOfOrders: JSON = [1000000, 1000001, 1000002]    // Prints:
                                                            //
jsonListOfOrders[2] = 1000005                               // [
jsonListOfOrders[1] = 1000003                               //     1000007,
jsonListOfOrders[0] = 1000007                               //     1000003,
                                                            //     1000005
print(jsonListOfOrders)                                     // ]
````

In addition to `Int` and `String`-indexed subscripts, there is a special case of `Void`-indexed subscript `[]`:

````swift
var jsonDynamicallyGrownArray: JSON = []            // Prints:
                                                    //
jsonDynamicallyGrownArray[].append("start"  )       // [
jsonDynamicallyGrownArray[].append(".")             //     "start",
jsonDynamicallyGrownArray[].append("..")            //     ".",
jsonDynamicallyGrownArray[].append("...end")        //     "..",
                                                    //     "...end"
print(jsonDynamicallyGrownArray)                    // ]
````

Main purpose of `[]` subcript is to provide a way to create/grow/shrink `JSON.Array`:

- When getter is applied to `.Array`, it unwraps and returns underlying array of `JSON` sub-elements.
- When getter is applied to any other `JSON` kind, it will create and return single-element array out of it.
- The setter will take input `[JSON]` array and create `JSON.Array` out of it.

For example, the following snippet will produce exactly same output as the one from above:

var jsonImplicitlyConvertedArray: JSON = "start"    // Prints:
                                                    //
jsonImplicitlyConvertedArray[].append("."  )        // [
jsonImplicitlyConvertedArray[].append("..")         //     "start",
jsonImplicitlyConvertedArray[].append("...end")     //     ".",
                                                    //     "..",
print(jsonImplicitlyConvertedArray)                 //     "...end"
                                                    // ]

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

... then it can implement `JSONEncodable` as follows:


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

> **Note:** Array `authors` and dictionary `notes` have to be explicitly encoded into `JSON` via `JSON(encoding: _)` initializer.  This is because there is no support (yet) for conditional protocol conformance by generics.  It [might appear in Swift 3](https://lists.swift.org/pipermail/swift-evolution/Week-of-Mon-20160229/011666.html), though.

Obvioulsy, with `JSONEncodable` implemented, we can encode `Book` instances into `JSON` by calling the method we just implemented:
 
````swift
let book = Book(                                            // Prints:
    title       : "Dune",                                   //
    pagesCount  : 896,                                      // {
    isPaperback : true,                                     //     "title": "Dune",
    authors     : ["Frank Herbert"],                        //     "isPaperback": true,
    notes       : [                                         //     "authors": [
        "2015-05-23": "Damaged. Handed over to repair.",    //         "Frank Herbert"
        "2015-06-10": "Repaired. Condition is good."        //     ],
    ]                                                       //     "notes": {
)                                                           //         "2015-05-23": "Damaged. Handed over to repair.",
                                                            //         "2015-06-10": "Repaired. Condition is good."
var jsonBook = book.jsonEncoded()                           //     },
                                                            //     "pages": 896
print(jsonBook)                                             // }
````
 
... or alternatively we can use the initializer:
 
````swift
let jsonAnotherBook = JSON(encoding: book)
````

As soon as `Book` is `JSONEncodable` we can also encode arrays and dictionaries that contain `Book`:

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

### Decoding

Decoding of `JSON` is also made possible via protocol implementation.  In this case it's `JSONDecodable` protocol.  

Keeping up with our `Book` as an example:

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

As soon as `JSONDecodable` is implemented, decoding of a new instance from `JSON` takes just a call to the initializer:

````swift
let anotherBook = try! Book(json: jsonBook)
````

### Serializing and deserializing
 
Method `jsonSerialized()` should be used both to serialize `JSON` values:
 
````swift
let serializedBook = jsonBook.jsonSerialized()
````

... as well as instances that conform to `JSONEncodable` protocol:
 
````swift
let anotherSerializedBook = book.jsonSerialized()
````

Special form of initializer `JSON(jsonSerialization: _)` can be used to deserialize `JSON` values:

> **Note:** Theoretically, a string that is used as an input for deserialization can be invalid.  That is why `JSON(jsonSerialization: _)` call can throw an error of `JSON.Error.Deserializing` type.
 
````swift
do {
    let jsonDeserialized = try JSON(jsonSerialization: serializedBook)
}
catch let error as JSON.Error.Deserializing {
    // Deserializing JSON failed.  Do something about it.
}
````

Similar form of initializer in available for types conforming to `JSONDecodable` protocol:

> **Note:** Deserialization of `Book` can throw a more error types.  On top of `JSON.Error.Deserializing` it can also throw `JSON.Error.Decoding` and `JSON.Error.Subscripting`:

````swift
do {
    let yetAnotherBook = try Book(jsonSerialization: serializedBook)
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

### Iterating over `JSON`

Container `JSON` kinds (`.Object` and `.Array`) can be iterated over.  For example, with `forEach()` method:

````swift
let jsonTodoList: JSON = ["Groceries", "Pick up kids", "Dinner"]    // Prints:
                                                                    //
jsonTodoList.forEach {                                              // [0] "Groceries"
    print($0, $1)                                                   // [1] "Pick up kids"
}                                                                   // [2] "Dinner"
````

> **Note:** Non-container `JSON` kinds can be iterated over as well, only there will be just one iteration made.


> **Note:** `JSONIndex` is `enum` with three cases: `.This` used for non-container `JSON`, `.Index(Int)` used for `.Array` and `.Key(String)` used for `.Object`.

Naturally, `map()`, `filter()` and all other methods applicable to sequences can be used with `JSON` too:

````swift
let pagerCountIndex = jsonBook.filter { $1 == 896 }     // Prints:
    .first?.index                                       //
print(pagerCountIndex)                                  // Optional(["pages"])
````

Iterating over `JSON` in a standard `for`-loop will only go over the surface without going deeper down into nested `JSON` sub-elements.  For this reason `JSON` offers special method `flatten()` that constructs an array of `(path: JSONPath, elemetaryValue: JSON)` tuples.  Such array will only contain basic `JSON` values (`.Null`, `.Boolean`, `.Integer`, `.Float` and `.String`), and each such value will be accompanied with a `JSONPath` that holds the indexes that have to be traversed from the root of `self` and all the way down to the particular basic element.

For example:

````swift
let dune = Book(                                            // Prints:
    title       : "Dune",                                   //
    pagesCount  : 896,                                      // {
    isPaperback : true,                                     //     "title": "Dune",
    authors     : ["Frank Herbert"],                        //     "isPaperback": true,
    notes       : [                                         //     "authors": [
        "2015-05-23": "Damaged. Handed over to repair.",    //         "Frank Herbert"
        "2015-06-10": "Repaired. Condition is good."        //     ],
    ]                                                       //     "notes": {
)                                                           //         "2015-05-23": "Damaged. Handed over to repair.",
                                                            //         "2015-06-10": "Repaired. Condition is good."
let jsonDune = book.jsonEncoded()                           //     },
                                                            //     "pages": 896
print(jsonDune)                                             // }
print()                                                     //
                                                            // jsonDune["title"] == "Dune"
jsonDune.flatten().forEach {                                // jsonDune["isPaperback"] == true
    (path: JSONPath, json: JSON) in                         // jsonDune["authors"][0] == "Frank Herbert"
                                                            // jsonDune["notes"]["2015-05-23"] == "Damaged. Handed over to repair."
    print("jsonDune\(path) == \(json)")                     // jsonDune["notes"]["2015-06-10"] == "Repaired. Condition is good."
}                                                           // jsonDune["pages"] == 896
                                                            // ["notes"]["2015-05-23"]
````

> **Note:** `JSONPath` is essentially an array of `JSONIndex` values.  It can be constructed from the sequence of `JSONIndex` values or from a literal.  It can be used in the subsript accessor as well.
