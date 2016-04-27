import Medea

let nullJSON: JSON = nil
let booleanJSON: JSON = true
let integerJSON: JSON = 42
let doubleJSON: JSON = 36.6
let stringJSON: JSON = "Lorem ipsum dolor sit amet"
let arrayJSON: JSON = [nullJSON, false, 1, 2.0, "3"]
let objectJSON: JSON = ["name": "John Doe", "age": 33, "weight": 66.6]

let arrayArrayJSON: JSON = [arrayJSON, arrayJSON, arrayJSON]
let arrayObjectJSON: JSON = [objectJSON, objectJSON, objectJSON]

custom