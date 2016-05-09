/*:
 
 [Previous](@previous) | [Top](0.%20Summary) | [Next](@next)
 
 - - -
 
 # `JSON` type
 
 The core of `Medea` framework is `JSON` type.  It becomes available once you improt the framework:
*/
        import Medea
/*:
 
 ## Literals
 
   It's possible to create an instance of `JSON` by just assigning a variable with literal value:
 
 */
        let booleanJSON: JSON = true
        let integerJSON: JSON = 42
        let doubleJSON: JSON = 36.6
        let stringJSON: JSON = "Lorem ipsum dolor sit amet"
        let arrayJSON: JSON = [false, 1, 2.0, "3"]
/*:
 
 ## Modifying `JSON` values:
 
 The value of `JSON` variable can be changed, e.g. like this:
 
 */
        var json: JSON = nil

        json = true
/*:
 
 ... and so forth.  Obviously, you can assing `json` now with any other literal.
 
 In addition, you can use `append()` method to turn it into a JSON array:
 
 */
        json.append(42)     // [true, 42]
        json.append(36.6)   // [true, 42, 36.6]
/*:
 
 Once you know that `json` is an array, you can modify elements by their indices:
 
 */
        json[0] = false     // [false, 42, 36.6]
        json[1] = -42       // [false, -42, 36.6]
/*:
 
 Similar approach can be taken with JSON object instances (a.k.a. dictionaries):
 
 */
        var object: JSON = [:]                  // {}

        object["id"] = 42                       // {"id": 42}
        object["description"] = "Lorem ipsum"   // {"id": 42, "description": "Lorem ipsum"}
        object["elements"] = json               // {"id": 42, "description": "Lorem ipsum", "elemens": [false, -42, 36.6]}
/*:
 
 ## Unwrapping `JSON` values
 
 Every `JSON` value (well, except `.Null`) is either a wrapper for some concrete basic type like `Bool`, `Int`, `Double` or `String`, or a container type (array or a dictionary).  For basic types, there are unwrapping accessor-properties like:
 
 */
        if let id = object["id"].unwrappedInteger {
            print(id)
        }
