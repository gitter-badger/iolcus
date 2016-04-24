/*:
 
 ## Quick start guide
 
 ### Serializing
 
 Let's model a library of books.  For starters we need some data-structure for a particular book.  It can look like:
 
 */
        struct Book {
            let title   : String
            let volume  : Int
            let authors : [String]
            let isbn    : String
        }
/*:
 
 Now, let's get a book:
 
 */
        let book = Book(
            title   : "War and Peace",
            volume  : 1,
            authors : ["Tolstoy, Leo", "Leo Tolstoy"],
            isbn    : "0140440623 / 9780140440621"
        )
/*:
 
 For this `Book` to be JSON encodeable, we have to adopt protocol `JSONEncodable` and implement just one method:
 
 */
        import Medea

        extension Book: JSONEncodable {
            
            func encodeJSON() -> JSON {
                let authors = JSON(withJSONEncodable: self.authors)
                let book: JSON = [
                    "title"   : title,
                    "volume"  : volume,
                    "authors" : authors,
                    "isbn"    : isbn
                ]
                return book
            }
            
        }

        let jsonBook = JSON(withJSONEncodable: book)
/*:
 
 Now `jsonBook` holds a JSON representation of `book`.  If we want to serialize it into a string, it's very simple:
 
 */
        let serializedBook = JSONSerialization.makeString(withJSON: jsonBook)

        // {"title": "War and Peace", "authors": ["Tolstoy, Leo"], "volume": 1, "isbn": "0140440623 \/ 9780140440621"}
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
            
            enum Error: ErrorType {
                case FailedToInstantiateFromJson(json: JSON)
            }
            
            init(json: JSON) throws {
                guard
                    let title = json["title"].string,
                    let volume = json["volume"].integer,
                    let isbn = json["isbn"].string,
                    let authors: [String] = try Array(json: json["authors"])
                else {
                    throw JSON.Error.Decodable.FailedToDecodeFromJSON(json: json, type: Book.self)
                }
                
                self.title = title
                self.volume = volume
                self.isbn = isbn
                self.authors = authors
            }
            
        }
/*:
 
 When this is done, just call the initializer like this:
 
 */
            let newBook = try! Book(json: anotherJSONBook)

            print(book)