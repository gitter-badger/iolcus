/*:
 
 [Previous](@previous) | [Top](Introduction) | [Next](@next)
 
 - - -
 
 ## Quick start guide
 
 ### Serializing
 
 Let's model a library of books.  For starters we need some data-structure for a particular book.  It can look like:
 
 */
        struct Book {
            let title       : String
            let authors     : [String]
            let isbn        : String
            let isPaperback : Bool
            let pages       : Int
            let custom      : [String: String]
        }
/*:
 
 Now, let's create a book:
 
 */
        let book = Book(
            title       : "Dune",
            authors     : ["Frank Herbert"],
            isbn        : "0441172717",
            isPaperback : true,
            pages       : 896,
            custom      : ["series": "Dune", "seriesNo": "1"]
        )
/*:
 
 For this `Book` to be JSON encodeable, we have to adopt protocol `JSONEncodable` and implement just one method:
 
 */
        import Medea

        extension Book: JSONEncodable {
            
            func encodeJSON() -> JSON {
                let jsonBook: JSON = [
                    "title"       : title,
                    "authors"     : JSON(encodable: authors),
                    "isbn"        : isbn,
                    "isPaperback" : isPaperback,
                    "pages"       : pages,
                    "custom"      : JSON(encodable: custom)
                ]
                return jsonBook
            }
            
        }

        let jsonBook = JSON(encodable: book)
/*:
 
 Now `jsonBook` instance holds a JSON representation of `book` instance.  If we want to serialize it into a string we can do:
 
 */
        let serializedBook = JSONSerialization.makeString(json: jsonBook)
/*:
 
 ### Deserializing
 
 For the reverse task, that is de-serializing an instance from JSON string, we simply take a serialized string and pass it to `JSONDeserialization` like this:
 
 */
        let anotherJSONBook = try! JSONDeserialization.makeJSON(string: serializedBook)
/*:
 
 Note `try!` in front of the call.  This is because actually we can get any string as an input, and not every such string can be deserialized into a valid `JSON` instance.  Therefore, you are supposed to handle errors that might occur (for the sake of clarity we will skip this for now, but have a look at the other chapters for how it's supposed to be done).

 The next step is to instantiacte a `Book` from `JSON` value.  This can be done by, firstly, adopting `JSONDecodable` protocol like this:
 
 */
        extension Book: JSONDecodable {
            
            init(json: JSON) throws {
                title       = try json.decode(at: "title")
                authors     = try json.decode(at: "authors")
                isbn        = try json.decode(at: "isbn")
                isPaperback = try json.decode(at: "isPaperback")
                pages       = try json.decode(at: "pages")
                custom      = try json.decode(at: "custom")
            }
            
        }
/*:
 
 And not we can instantiate a new `Book` instance from a `JSON` value like this:
 
 */
        let newBook = try! Book(json: anotherJSONBook)
/*:
 
 Or it can be even simpler than that:
 
 */
        let newerBook = try! Book(jsonSerialization: serializedBook)
/*:
 
 And, oh, by the way, serializing of an JSON encodeable instance can be done simpler as well:
 
 */
        let anotherSerializedBook = newerBook.serializeJSON()

        let library = [book, newBook, newerBook]

        let serializedLibrary = library.serializeJSON()

        let anotherLibrary: [Book] = try! Array(jsonSerialization: serializedLibrary)

        print(anotherLibrary)
        