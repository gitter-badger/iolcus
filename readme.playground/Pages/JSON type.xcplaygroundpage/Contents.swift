/*:
 
 [Previous](@previous) | [Top](Introduction) | [Next](@next)
 
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
 
 ## Mutating `JSON` values:
 
 The value of `JSON` variable can be changed.
 
 */
        var json: JSON = nil    // It's Null at the moment

        json = 1                // But we can still assing it with literal values
        json = "Lorem ipsum"

        let someDouble = 36.6
        json = JSON(double: someDouble)

        json.append(42)
        json[0] = 57

        print(json)
