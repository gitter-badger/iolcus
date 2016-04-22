import Medea

var json: JSON = [1, 2.0, "3"]

json[0] = 12.0

json[2] = true

json.array?.append(111)

json.object = ["index": "value"]

var json2: JSON = [:]

json2["name"] = "Anton"
json2["address"] = "Northern forest"
json2["stuff"] = json

print(json2)

var bar = [1]

bar.append(2)