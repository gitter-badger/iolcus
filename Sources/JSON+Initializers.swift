//
//  JSON+Initializers.swift
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

extension JSON {
    
    /// Creates a `JSON` value from an instance of `JSONEncodable`.
    public init(encodable: JSONEncodable) {
        self = encodable.jsonEncoded()
    }
    
    /// Creates a `JSON` value from an array of `JSONEncodable`'s.
    public init<Encodable: JSONEncodable>(encodable: [Encodable]) {
        self = encodable.jsonEncoded()
    }
    
    /// Creates a `JSON` value from an array of `JSONEncodable`'s.
    public init(encodable: [JSONEncodable]) {
        let elements = encodable.map {
            $0.jsonEncoded()
        }
        
        self = .Array(elements: elements)
    }
    
    /// Creates a `JSON` value from a dictionary of `[String: JSONEncodable]`.
    public init<Encodable: JSONEncodable>(encodable: [Swift.String: Encodable]) {
        self = encodable.jsonEncoded()
    }
    
    /// Creates a `JSON` value from a dictionary of `[String: JSONEncodable]`.
    public init(encodable: [Swift.String: JSONEncodable]) {
        var properties: [Swift.String: JSON] = [:]
        
        encodable.forEach {
            properties[$0] = $1.jsonEncoded()
        }
        
        self = .Object(properties: properties)
    }
    
}
