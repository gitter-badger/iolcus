import Medea

let json: JSON = [1, 2.0, "3", true, false]
let json2: JSON = ["key": json]

JSONSerialization.stringWithJSON(json2)