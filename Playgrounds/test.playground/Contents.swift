import Medea

let json0: JSON = ["Lorem", "ipsum"]

let json1: JSON = [false, 1, 2.0, "III", json0]

var json2: JSON = [
    "name"  : "Object",
    "index" : 1,
    "array" : json1
]

let path: JSONPath = ["array", 4, 0]

print(json2)

json2[path] = "Dolor"

print(json2)

path