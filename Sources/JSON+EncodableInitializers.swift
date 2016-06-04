//
//  JSON+EncodableInitializers.swift
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

    // MARK: JSONEncodable

    /// Create `JSON` value from `JSONEncodable`.
    public init(encoding instance: JSONEncodable) {
        self = instance.jsonEncoded()
    }

    // MARK: - [JSONEncodable]

    /// Create `JSON` value from `[JSONEncodable]`.
    public init(encoding array: [JSONEncodable]) {
        let elements = array.map {
            $0.jsonEncoded()
        }

        self = .Array(elements)
    }

    /// Create `JSON` value from `[JSONEncodable]`.
    public init<J: JSONEncodable>(encoding array: [J]) {
        let elements = array.map {
            $0.jsonEncoded()
        }

        self = .Array(elements)
    }
    
    // MARK: - [StringConvertible: JSONEncodable]

    /// Create `JSON` value from `[StringConvertible: JSONEncodable]`.
    public init<S: StringConvertible>(encoding dictionary: [S: JSONEncodable]) {
        var properties: [Swift.String: JSON] = [:]

        dictionary.forEach {
            let key = $0.stringConverted()
            let value = $1.jsonEncoded()
            properties[key] = value
        }

        self = .Object(properties)
    }

    /// Create `JSON` value from `[StringConvertible: JSONEncodable]`.
    public init<S: StringConvertible, J: JSONEncodable>(encoding dictionary: [S: J]) {
        var properties: [Swift.String: JSON] = [:]

        dictionary.forEach {
            let key = $0.stringConverted()
            let value = $1.jsonEncoded()
            properties[key] = value
        }

        self = .Object(properties)
    }

    // MARK: - [StringConvertible: [JSONEncodable]]

    public init<S: StringConvertible>(encoding arraysDictionary: [S: [JSONEncodable]]) {
        var properties: [Swift.String: JSON] = [:]

        arraysDictionary.forEach { (key: S, array: [JSONEncodable]) in
            let convertedKey = key.stringConverted()
            let convertedArray = array.map {
                $0.jsonEncoded()
            }
            properties[convertedKey] = .Array(convertedArray)
        }

        self = .Object(properties)
    }

    /// Create `JSON` value from `[StringConvertible: [JSONEncodable]]`.
    public init<S: StringConvertible, J: JSONEncodable>(encoding arraysDictionary: [S: [J]]) {
        var properties: [Swift.String: JSON] = [:]

        arraysDictionary.forEach { (key: S, array: [J]) in
            let convertedKey = key.stringConverted()
            let convertedArray = array.map {
                $0.jsonEncoded()
            }
            properties[convertedKey] = .Array(convertedArray)
        }

        self = .Object(properties)
    }
    
}
