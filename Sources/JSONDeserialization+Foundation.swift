//
//  JSONDeserialization+Foundation.swift
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

extension JSONDeserialization {
    
    // MARK: - Public API
    
    /// Makes `JSON` value from Foundation JSON object.
    ///
    /// - note: Foundation represents original JSON's number and JSON's boolean as `NSNumber`
    ///         object.  This means that there is really no way to recognize one from the other
    ///         while converting into Medea's `JSON` (that is very type-strict).  Therefore, it can
    ///         be that something that was originally serialized as a boolean will end up being
    ///         `.Double` if it is deserialized into a Foundation object first and only then
    ///         converted into Medea's `JSON`.
    public static func makeJSON(withFoundationJSON nsjson: AnyObject) throws -> JSON {
        if let json = nsjson as? [NSString: AnyObject] {
            return try makeJSON(withFoundationJSON: json)
        }
        
        if let json = nsjson as? [AnyObject] {
            return try makeJSON(withFoundationJSON: json)
        }
        
        if let json = nsjson as? NSString {
            return try makeJSON(withFoundationJSON: json)
        }
        
        if let json = nsjson as? NSNumber {
            return try makeJSON(withFoundationJSON: json)
        }
        
        if let json = nsjson as? NSNull {
            return try makeJSON(withFoundationJSON: json)
        }
        
        throw Error.Converting.FailedToConvertFromFoundationJSON(type: nsjson.dynamicType)
    }
    
    // MARK: - Internal
    
    private static func makeJSON(withFoundationJSON nsjson: NSNull) throws -> JSON {
        return .Null
    }
    
    private static func makeJSON(withFoundationJSON nsjson: NSNumber) throws -> JSON {
        let double = nsjson.doubleValue
        return .Double(double)
    }
    
    private static func makeJSON(withFoundationJSON nsjson: NSString) throws -> JSON {
        let string = nsjson as Swift.String
        return .String(string)
    }
    
    private static func makeJSON(withFoundationJSON nsjson: [AnyObject]) throws -> JSON {
        let array = try nsjson.map() {
            try makeJSON(withFoundationJSON: $0)
        }
        return .Array(array)
    }
    
    private static func makeJSON(withFoundationJSON nsjson: [NSString: AnyObject]) throws -> JSON {
        var properties: [Swift.String: JSON] = [:]
        try nsjson.forEach() {
            let key = $0 as Swift.String
            let value = try makeJSON(withFoundationJSON: $1)
            properties[key] = value
        }
        return .Object(properties)
    }
    
}

// MARK: - Error definitions

extension JSONDeserialization.Error {

    /// Exception while coverting to/from Foundation representation of JSON.
    public enum Converting: ErrorType {
        
        /// Failed to convert from Foundation `JSON` representation into Medea `JSON`.
        case FailedToConvertFromFoundationJSON(type: Any.Type)
        
    }
   
}

#endif
