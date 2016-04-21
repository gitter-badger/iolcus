//
//  JSONSerialization+Foundation.swift
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

extension JSONSerialization {
    
    // MARK: - Public API
    
    /// Converts Medea's `JSON` value into a Foundation representation.
    public static func makeFoundationJSON(withJSON json: JSON) -> AnyObject {
        switch json {

        case .Null:
            return makeFoundationJSONWithNull()
        
        case .Boolean(let boolean):
            return makeFoundationJSON(withBoolean: boolean)
            
        case .Integer(let integer):
            return makeFoundationJSON(withInteger: integer)
        
        case .Double(let double):
            return makeFoundationJSON(withDouble: double)
        
        case .String(let string):
            return makeFoundationJSON(withString: string)
        
        case .Array(let elements):
            return makeFoundationJSON(withArray: elements)
        
        case .Object(let properties):
            return makeFoundationJSON(withObject: properties)
        
        }
    }
    
    // MARK: - Internal
    
    private static func makeFoundationJSONWithNull() -> AnyObject {
        return NSNull()
    }
    
    private static func makeFoundationJSON(withBoolean boolean: Bool) -> AnyObject {
        return NSNumber.init(bool: boolean)
    }
    
    private static func makeFoundationJSON(withInteger integer: Int) -> AnyObject {
        return NSNumber(integer: integer)
    }
    
    private static func makeFoundationJSON(withDouble double: Swift.Double) -> AnyObject {
        return NSNumber(double: double)
    }
    
    private static func makeFoundationJSON(withString string: Swift.String) -> AnyObject {
        return NSString(string: string)
    }
    
    private static func makeFoundationJSON(withArray elements: [JSON]) -> AnyObject {
        return elements.map() {
            makeFoundationJSON(withJSON: $0)
        }
    }
    
    private static func makeFoundationJSON(withObject properties: [Swift.String: JSON]) -> AnyObject {
        var nsjsonProperties: [NSString: AnyObject] = [:]
        properties.forEach() {
            nsjsonProperties[$0] = makeFoundationJSON(withJSON: $1)
        }
        return nsjsonProperties
    }

}

#endif
