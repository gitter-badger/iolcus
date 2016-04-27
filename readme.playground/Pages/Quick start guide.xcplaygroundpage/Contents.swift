/*:
 
 [Previous](@previous) | [Top](Introduction) | [Next](@next)
 
 - - -
 
 ## Quick start guide
 
 ### Serializing
 
 Let's model a library of books.  For starters we need some data-structure for a particular book.  It can look like:
 
 */
        struct Book {
            let title       : String
            let pages       : Int
            let isPaperback : Bool
            let authors     : [String]
            let notes       : [String: String]
        }
/*:
 
 Now, let's create a book:
 
 */
        let book = Book(
            title       : "Dune",
            pages       : 896,
            isPaperback : true,
            authors     : ["Frank Herbert"],
            notes       : ["series": "Dune", "seriesNo": "1"]
        )

        // Book(title: "Dune", pages: 896, isPaperback: true, authors: ["Frank Herbert"], notes: ["series": "Dune", "seriesNo": "1"])
/*:
 
 For this `Book` to be JSON encodeable, that is serializable into JSON string, we have to adopt protocol `JSONEncodable` by implementing just one method `encodeJSON()` like this:
 
 */
        import Medea

        extension Book: JSONEncodable {
            
            func encodeJSON() -> JSON {
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
 
 Now that this is done, we can serialize `book` into a JSON string by simply calling `serializeJSON()` method:
 
 */
        let serializedBook = book.serializeJSON()

        // {"title": "Dune", "isPaperback": true, "authors": ["Frank Herbert"], "notes": {"series": "Dune", "seriesNo": "1"}, "pages": 896}
/*:
 
 ### Deserializing
 
 For the reverse task, that is de-serializing an instance from a JSON string, we we have to adopt another protocol `JSONDecodable` as follows:
 
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
 
 Once the protocol is implemented, we can just call:
 
 */
        let anotherBook = try! Book(jsonSerialization: serializedBook)

        // Book(title: "Dune", pages: 896, isPaperback: true, authors: ["Frank Herbert"], notes: ["series": "Dune", "seriesNo": "1"])
