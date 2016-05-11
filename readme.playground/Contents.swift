/*:
  
 # `JSON @ Medea`
  
 The core of `Medea` framework is `JSON` type.  In practice it's just an enum like:
 ````
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
 
 ## Literals
 
 It's possible to create an instance of `JSON` by just assigning a variable with literal value:
  
 */
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
/*:
 
 ## Initializers
 
 Alternative ways to instantiate `JSON`:
 
 */
        let anotherIntegerJSON = JSON.Integer(99)
        let anotherBooleanJSON = JSON(encodable: true)
        let anotherStringJSON = try! JSON(json: objectJSON, at: "string")
        let anotherArrayJSON = try! JSON(serialization: "[false, 1, 2.0, \"3\"]")
/*:
 
 ## Unwrapping
 
 Every `JSON` value (except `.Null`) is a wrapper around some basic value (`Bool`, `Int`, `Double`, `String`) or around a container (`[JSON]` or `[String: JSON]`).  It is possible to access a particular kind of wrapped instance via dedicated optional property.  For example:
  
*/
        if let boolean = booleanJSON.unwrappedBoolean {
            print(boolean) // Prints "true"
        }
/*:
 
 ... or:
  
 */
        if let properties = objectJSON.unwrappedObject {
            if let string = properties["string"]?.unwrappedString {
                print(string) // Prints "Lorem ipsum"
            }
        }
/*:
 
 ## Subscripting
 
 Elements in an array and object `JSON` kinds can be reached via subscripts:
  
 */
        if let integer = objectJSON["integer"].unwrappedInteger {
            print(integer) // Prints "42"
        }

        if let double = arrayJSON[2].unwrappedDouble {
            print(double) // Prints "2.0"
        }
/*:
  
 ## Coercing
  
 Sometimes JSON messages come serialized as a pile strings for just everything: boolean, integer, float, whatever.  This is when coercion could be handy.  E.g.:
  
 */
        let something: JSON = "365"
 
        if let integer = something.asInteger {
            print(integer) // Prints "365"
        }
/*:

 ## Encoding

 If you want to encode/serialize some type into `JSON` then it will suffice to just adopt `JSONEncodable` protocol.  Let say we have a `Book` type:
 
 */
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
/*:
 
 Then we could implement `JSONEncodable` protocol like this:
 
 */
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
/*:
 
 Now this is done we can convert `Book` instances into `JSON` like this:
 
 */
        let jsonBook = book.jsonEncoded()
        let anotherJSONBook = JSON(encodable: book)
        let arrayOfJSONBooks = JSON(encodable: [book, book, book])
/*:
 
 Moreover, we can now serialize `Book` instances like:
 
 */
        let serializedBook = book.jsonSerialized()
        let serializedArray = [book, book, book].jsonSerialized()
/*:
 
 ## Decoding
 
 Reverse task, that is decoding/deserializing an instance from `JSON` requires `JSONDecodable` protocol implemented.  For example:
 
 */
        extension Book: JSONDecodable {
            init(json: JSON) throws {
                title       = try json.decode(at: "title")
                pages       = try json.decode(at: "pages")
                isPaperback = try json.decode(at: "isPaperback")
                authors     = try json.decode(at: "authors")
                notes       = try json.decode(at: "notes")
            }
        }
/*:
 
 With this protocol, creating a new instance from `JSON` takes just:
 
 */
        let anotherBook = try! Book(json: jsonBook)
/*:

 ... and deserializing a JSON string is done with:
 
 */
        let yetAnotherBook = try! Book(serialization: serializedBook)
/*:
 
 ## Traversing
 
 Container `JSON` kinds (object and array) can be looped trhough:
 
 */
        arrayJSON.forEach() {
            print($0, $1) // $0 is `JSONIndex` and `$1` is child-node of `JSON`
        }

        for (key, node) in objectJSON {
            print(key, node)
        }
