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
            let volume      : Int
            let isPaperback : Bool
            let custom      : [String: String]
        }
/*:
 
 Now, let's get a book:
 
 */
        let book = Book(
            title       : "War and Peace",
            authors     : ["Tolstoy, Leo", "Leo Tolstoy"],
            volume      : 1,
            isPaperback : false,
            custom      : ["Note 1": "Veeeeeeeery long", "Note 2": "Still, must read"]
        )
/*:
 
 For this `Book` to be JSON encodeable, we have to adopt protocol `JSONEncodable` and implement just one method:
 
 */
        import Medea

        extension Book: JSONEncodable {
            
            func encodeJSON() -> JSON {
                let jsonBook: JSON = [
                    "title"       : title,
                    "volume"      : volume,
                    "isPaperback" : isPaperback,
                    "authors"     : JSON(encodable: authors),
                    "custom"      : JSON(encodable: custom)
                ]
                return jsonBook
            }
            
        }

        let jsonBook = JSON(encodable: book)
/*:
 
 Now `jsonBook` holds a JSON representation of `book`.  If we want to serialize it into a string, it's very simple:
 
 */
        let serializedBook = JSONSerialization.makeString(json: jsonBook)
/*:
 
 ### Deserializing
 
 For the reverse task, that is de-serializing an instance from JSON string, we simply take a serialized string and pass it to `JSONDeserialization`
 
 */
        let anotherJSONBook = try! JSONDeserialization.makeJSON(string: serializedBook)
/*:
 
 Note `try!` in front of the call.  This is because actually we can get any string as an input, and not every such string can be deserialized into a valid `JSON` instance.  Therefore, you are supposed 

 The next step is to instantiacte a `Book` from `JSON` value.  This can be done by adopting `JSONDecodable` like this:
 
 */
        extension Book: JSONDecodable {
            
            init(json: JSON) throws {
                title       = try String(json: json, at: "title")
                volume      = try Int(json: json, at: "volume")
                isPaperback = try Bool(json: json, at: "isPaperback")
                authors     = try Array(json: json, at: "authors")
                custom      = try Dictionary(json: json, at: "custom")
            }
            
        }
/*:
 
 When this is done, just call the initializer like this:
 
 */
        let newBook = try! Book(json: anotherJSONBook)

