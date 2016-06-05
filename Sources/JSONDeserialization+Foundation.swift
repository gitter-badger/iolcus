//
//  JSONDeserialization+Foundation.swift
//  Iolcus
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

//#if os(OSX) || os(iOS) || os(tvOS)
//    
//    import Foundation
//    
//    extension JSONDeserialization {
//        
//        // MARK: - Public API
//        
//        /// Makes Iolcus `JSON` value using Foundation's `AnyObject` representation of JSON.
//        ///
//        /// - note: Foundation represents JSON's number and boolean as the same internal type, namely
//        ///         `NSNumber`.  This means that there is really no way to tell one from another while
//        ///         converting from Foundation to Iolcus.  JSON's `true` will end up as `.Integer(1)`
//        ///         this way and `false` will be `.Integer(0)`.
//        ///
//        /// - Throws: `JSON.Error.Converting`
//        public static func makeJSON(jsonAnyObject anyObject: AnyObject) throws -> JSON {
//            if let null = anyObject as? NSNull {
//                return try makeJSON(null: null)
//            }
//
//            if let number = anyObject as? NSNumber {
//                return try makeJSON(number: number)
//            }
//
//            if let string = anyObject as? NSString {
//                return try makeJSON(string: string)
//            }
//
//            if let array = anyObject as? [AnyObject] {
//                return try makeJSON(array: array)
//            }
//            
//            if let object = anyObject as? [NSString: AnyObject] {
//                return try makeJSON(object: object)
//            }
//            
//            throw JSON.Error.Converting.FailedToConvertFromAnyObject(type: anyObject.dynamicType)
//        }
//        
//        // MARK: - Internal
//        
//        private static func makeJSON(null null: NSNull) throws -> JSON {
//            return .Null
//        }
//        
//        private static func makeJSON(number number: NSNumber) throws -> JSON {
//            if Double(number.integerValue) == number.doubleValue {
//                return .Integer(number.integerValue)
//            } else {
//                return .Float(number.doubleValue)
//            }
//        }
//        
//        private static func makeJSON(string string: NSString) throws -> JSON {
//            let string = string as Swift.String
//            return .String(string)
//        }
//        
//        private static func makeJSON(array array: [AnyObject]) throws -> JSON {
//            let elements = try array.map {
//                try makeJSON(jsonAnyObject: $0)
//            }
//            return .Array(elements)
//        }
//        
//        private static func makeJSON(object object: [NSString: AnyObject]) throws -> JSON {
//            var properties: [Swift.String: JSON] = [:]
//            
//            try object.forEach {
//                let key = $0 as Swift.String
//                let value = try makeJSON(jsonAnyObject: $1)
//                properties[key] = value
//            }
//            
//            return .Object(properties)
//        }
//        
//    }
//
//    // MARK: - Errors
//
//    extension JSON.Error {
//
//        /// Exception while coverting to/from Foundation representation of JSON.
//        public enum Converting: ErrorType {
//
//            /// Failed to convert from Foundation `JSON` representation into Iolcus `JSON`.
//            case FailedToConvertFromAnyObject(type: Any.Type)
//            
//        }
//        
//    }
//
//#endif
