//import Medea
//
//let json0: JSON = ["Lorem", "ipsum"]
//
//let json1: JSON = [false, 1, 2.0, "false", json0]
//
//json1[3].asString
//
//
//var json2: JSON = [
//    "name"  : "Object",
//    "index" : 1,
//    "array" : json1
//]
//
//let path: JSONPath = ["array", 4, 0]
//
//json2[path] = "Dolor"
//
//for foo in json2 {
//    print(foo.index, foo.json)
//}
//
//extension JSON: CollectionType {
//
//    typealias Index = JSONIndex
//    
//    public var startIndex: JSONIndex {
//        switch self {
//            
//        case .Null, .Boolean(_), .Integer(_), .Double(_), .String(_):
//            return JSONIndex.This
//            
//        case .Array(let elements):
//            let position = elements.startIndex
//            return JSONIndex.Position(position)
//            
//        case .Object(let properties):
//            let index = properties.startIndex
//            let (name, _) = properties[index]
//            return JSONIndex.Name(name)
//            
//        }
//    }
//    
//    public var endIndex: JSONIndex {
//        return JSONIndex.This
//    }
//    
//}

var dict = [1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, 8: 8]

for index in dict.startIndex..<dict.endIndex {
    print(dict.startIndex.distanceTo(index), dict[index])
    
    if dict.startIndex.distanceTo(index) == 1 {
        let anotherIndex = index.advancedBy(5)
        dict.removeAtIndex(anotherIndex)
    }
}



