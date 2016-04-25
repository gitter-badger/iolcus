/*:
 
 ## Quick start guide
 
 ### Serializing
 
 Let's model a library of books.  For starters we need some data-structure for a particular book.  It can look like:
 
 */
        struct Book {
            let title       : String
            let authors     : [String]
            let volume      : Int
            let isPaperback : Bool
        }
/*:
 
 Now, let's get a book:
 
 */
        let book = Book(
            title       : "War and Peace",
            authors     : ["Tolstoy, Leo", "Leo Tolstoy"],
            volume      : 1,
            isPaperback : false
        )
/*:
 
 For this `Book` to be JSON encodeable, we have to adopt protocol `JSONEncodable` and implement just one method:
 
 */
        import Medea

        extension Book: JSONEncodable {
            
            func encodeJSON() -> JSON {
                let jsonAuthors = JSON(withJSONEncodable: authors)
                let jsonBook: JSON = [
                    "title"       : title,
                    "authors"     : jsonAuthors,
                    "volume"      : volume,
                    "isPaperback" : isPaperback
                ]
                return jsonBook
            }
            
        }

        let jsonBook = JSON(withJSONEncodable: book)
/*:
 
 Now `jsonBook` holds a JSON representation of `book`.  If we want to serialize it into a string, it's very simple:
 
 */
        let serializedBook = JSONSerialization.makeString(withJSON: jsonBook)
/*:
 
 ### Deserializing
 
 For the reverse task, that is de-serializing an instance from JSON string, we simply take a serialized string and pass it to `JSONDeserialization`
 
 */
        let anotherJSONBook = try! JSONDeserialization.makeJSON(withString: serializedBook)
/*:
 
 Note `do-catch` around the call.  This is because actually we can get any string as an input, and not every such string can be deserialized into a valid `JSON` instance.

 The next step is to instantiacte a `Book` from `JSON` value.  This can be done by adopting `JSONDecodable` like this:
 
 */
        extension Book: JSONDecodable {
            
            init(json: JSON) throws {
                title = try String(json: json["title"])
                volume = try Int(json: json["volume"])
                authors = try Array(json: json["authors"])
                isPaperback = try Bool(json: json["isPaperback"])
            }
            
        }
/*:
 
 When this is done, just call the initializer like this:
 
 */
            let newBook = try! Book(json: anotherJSONBook)

            print(book, newBook, separator: "\n")
