//
//  JSONDeserialization.swift
//  Medea
//
//  Copyright (c) 2016 Anton Bronnikov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

public struct JSONDeserialization {
    
    private init() { }
    
}

// MARK: - Exposed API

extension JSONDeserialization {
    
    public static func generatorWithJSON(json: JSON) -> AnyGenerator<Character> {
        switch json {
        case .Null:
            return AnyGenerator(JSONNUllDeserialization())
        case .Boolean(let boolean):
            return AnyGenerator(JSONBoolDeserialization(boolean))
        case .Integer(let integer):
            return AnyGenerator(JSONIntegerDeserialization(integer))
        case .Double(let double):
            return AnyGenerator(JSONDoubleDeserialization(double))
        case .String(let string):
            return AnyGenerator(JSONStringDeserialization(string))
        case .Array(let values):
            return AnyGenerator(JSONArrayDeserialization(values))
        case .Object(let properties):
            return AnyGenerator(JSONObjectDeserialization(properties))
        }
    }
    
    public static func sequenceWithJSON(json: JSON) -> AnySequence<Character> {
        return AnySequence(GeneratorSequence(generatorWithJSON(json)))
    }
    
    public static func stringWithJSON(json: JSON) -> String {
        return String(GeneratorSequence(generatorWithJSON(json)))
    }
    
}

// MARK: - Foundation version of JSON

#if os(OSX) || os(iOS) || os(tvOS)

extension JSONDeserialization {
    
    public static func nsjsonWithJSON(json: JSON) -> AnyObject {
        switch json {
        case .Null:
            return nsjsonWithNull()
        case .Boolean(let boolean):
            return nsjsonWithBoolean(boolean)
        case .Integer(let integer):
            return nsjsonWithInteger(integer)
        case .Double(let double):
            return nsjsonWithDouble(double)
        case .String(let string):
            return nsjsonWithString(string)
        case .Array(let elements):
            return nsjsonWithArray(elements)
        case .Object(let properties):
            return nsjsonWithObject(properties)
        }
    }
    
    private static func nsjsonWithNull() -> AnyObject {
        return NSNull()
    }

    private static func nsjsonWithBoolean(jsonBoolean: Bool) -> AnyObject {
        return NSNumber.init(bool: jsonBoolean)
    }

    private static func nsjsonWithInteger(jsonInteger: Int) -> AnyObject {
        return NSNumber(integer: jsonInteger)
    }

    private static func nsjsonWithDouble(jsonDouble: Double) -> AnyObject {
        return NSNumber(double: jsonDouble)
    }

    private static func nsjsonWithString(jsonString: String) -> AnyObject {
        return NSString(string: jsonString)
    }

    private static func nsjsonWithArray(jsonElements: [JSON]) -> AnyObject {
        return jsonElements.map() {
            nsjsonWithJSON($0)
        }
    }

    private static func nsjsonWithObject(jsonProperties: [String: JSON]) -> AnyObject {
        var nsjsonProperties: [NSString: AnyObject] = [:]
        jsonProperties.forEach() {
            nsjsonProperties[$0] = nsjsonWithJSON($1)
        }
        return nsjsonProperties
    }
    
}

#endif
