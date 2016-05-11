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
        
        /// Makes Foundation's `AnyObject` representation of JSON using Medea's `JSON` value.
        public static func makeAnyObject(json json: JSON) -> AnyObject {
            switch json {
                
            case .Null:
                return makeAnyObject(null: ())
                
            case .Boolean(let boolean):
                return makeAnyObject(boolean: boolean)
                
            case .Integer(let integer):
                return makeAnyObject(integer: integer)
                
            case .Double(let double):
                return makeAnyObject(double: double)
                
            case .String(let string):
                return makeAnyObject(string: string)
                
            case .Array(let elements):
                return makeAnyObject(array: elements)
                
            case .Object(let properties):
                return makeAnyObject(object: properties)
                
            }
        }
        
        // MARK: - Internal
        
        private static func makeAnyObject(null null: Void) -> AnyObject {
            return NSNull()
        }
        
        private static func makeAnyObject(boolean boolean: Bool) -> AnyObject {
            return NSNumber.init(bool: boolean)
        }
        
        private static func makeAnyObject(integer integer: Int) -> AnyObject {
            return NSNumber(integer: integer)
        }
        
        private static func makeAnyObject(double double: Swift.Double) -> AnyObject {
            return NSNumber(double: double)
        }
        
        private static func makeAnyObject(string string: Swift.String) -> AnyObject {
            return NSString(string: string)
        }
        
        private static func makeAnyObject(array elements: [JSON]) -> AnyObject {
            return elements.map() {
                makeAnyObject(json: $0)
            }
        }
        
        private static func makeAnyObject(object properties: [Swift.String: JSON]) -> AnyObject {
            var nsjsonProperties: [NSString: AnyObject] = [:]
            properties.forEach() {
                nsjsonProperties[$0] = makeAnyObject(json: $1)
            }
            return nsjsonProperties
        }
        
    }
    
#endif
