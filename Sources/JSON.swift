//
//  JSON.swift
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

/// `JSON` value.
///
/// Enumeration of:
/// - `Null`
/// - `Boolean(Bool)`
/// - `Integer(Int)`
/// - `Double(Double)`
/// - `String(String)`
/// - `Array(elements: [JSON])`
/// - `Object(properties: [String: JSON])`
public indirect enum JSON {
    
    /// Null JSON value.
    case Null
    
    /// Boolean JSON value.
    case Boolean(Swift.Bool)
    
    /// JSON integer value.
    case Integer(Swift.Int)
    
    /// JSON double value.
    case Double(Swift.Double)
    
    /// JSON string value.
    case String(Swift.String)
    
    /// JSON array.
    case Array(elements: [JSON])
    
    /// JSON object.
    case Object(properties: [Swift.String: JSON])
    
    /// Generic JSON-related error.
    public struct Error {
        private init() {}
    }
    
}

extension JSON {
    
    mutating public func append(json: JSON) {
        switch self {
            
        case .Array(let elements):
            var newElements = elements
            newElements.append(json)
            self = .Array(elements: newElements)
            
        default:
            let newElements = [self, json]
            self = .Array(elements: newElements)
            
        }
    }
    
}
