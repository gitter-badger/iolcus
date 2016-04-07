//
//  JSON+Foundation.swift
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

#if os(OSX) || os(iOS) || os(tvOS)

import Foundation

// MARK: Foundation -> Medea
    
extension JSON {
    
    /// Converts an object with Foundation representation of the JSON into Medea `JSON`.
    /// 
    /// - note: Foundation represents original JSON's number and JSON's boolean as `NSNumber` 
    ///         object.  This means that there is really no way to recognize one from the other
    ///         while converting into Medea's `JSON` (that is very type-strict).  Therefore, it can
    ///         be that something that was originally serialized as a boolean will end up being 
    ///         `.Double` if it is deserialized into a Foundation object first and only then 
    ///         converted into Medea's `JSON`.
    public static func jsonWithNSJSON(nsjson: AnyObject) throws -> JSON {
        if let json = nsjson as? [NSString: AnyObject] {
            return try jsonWithNSJSON(json)
        }
        
        if let json = nsjson as? [AnyObject] {
            return try jsonWithNSJSON(json)
        }
        
        if let json = nsjson as? NSString {
            return try jsonWithNSJSON(json)
        }
        
        if let json = nsjson as? NSNumber {
            return try jsonWithNSJSON(json)
        }
        
        if let json = nsjson as? NSNull {
            return try jsonWithNSJSON(json)
        }
        
        throw JSON.Exception.Serializing.FailedToReadNSJSON(type: nsjson.dynamicType)
    }
    
    // MARK: -
    
    private static func jsonWithNSJSON(nsjson: NSNull) throws -> JSON {
        return .Null
    }
    
    private static func jsonWithNSJSON(nsjson: NSNumber) throws -> JSON {
        let double = nsjson.doubleValue
        return .Double(double)
    }
    
    private static func jsonWithNSJSON(nsjson: NSString) throws -> JSON {
        let string = nsjson as Swift.String
        return .String(string)
    }
    
    private static func jsonWithNSJSON(nsjson: [AnyObject]) throws -> JSON {
        let array = try nsjson.map() {
            try jsonWithNSJSON($0)
        }
        return .Array(array)
    }
    
    private static func jsonWithNSJSON(nsjson: [NSString: AnyObject]) throws -> JSON {
        var properties: [Swift.String: JSON] = [:]
        try nsjson.forEach() {
            let key = $0 as Swift.String
            let value = try jsonWithNSJSON($1)
            properties[key] = value
        }
        return .Object(properties)
    }
    
}

// MARK: - Medea -> Foundation
    
extension JSON {
        
    /// Converts Medea's `JSON` value into a Foundation representation.
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
    
    // MARK: -

    private static func nsjsonWithNull() -> AnyObject {
        return NSNull()
    }
    
    private static func nsjsonWithBoolean(jsonBoolean: Bool) -> AnyObject {
        return NSNumber.init(bool: jsonBoolean)
    }
    
    private static func nsjsonWithInteger(jsonInteger: Int) -> AnyObject {
        return NSNumber(integer: jsonInteger)
    }
    
    private static func nsjsonWithDouble(jsonDouble: Swift.Double) -> AnyObject {
        return NSNumber(double: jsonDouble)
    }
    
    private static func nsjsonWithString(jsonString: Swift.String) -> AnyObject {
        return NSString(string: jsonString)
    }
    
    private static func nsjsonWithArray(jsonElements: [JSON]) -> AnyObject {
        return jsonElements.map() {
            nsjsonWithJSON($0)
        }
    }
    
    private static func nsjsonWithObject(jsonProperties: [Swift.String: JSON]) -> AnyObject {
        var nsjsonProperties: [NSString: AnyObject] = [:]
        jsonProperties.forEach() {
            nsjsonProperties[$0] = nsjsonWithJSON($1)
        }
        return nsjsonProperties
    }
    
}
    
#endif
