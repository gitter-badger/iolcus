//
//  JSONSerialization.swift
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

public struct JSONSerialization {

    // MARK: - Public API
    
    /// Create a string by serializing `JSON` value.
    /// 
    /// - parameters:
    ///   - json: Input `JSON` value.
    ///   - prettyPrint: 
    ///     ⁃ `false` (default) generates the most condense output possible (no whitespace). \
    ///     ⁃ `true` produces the string formatted for readability.
    ///
    /// - returns: String with the serialization of an input `json`.
    public static func makeString(json json: JSON, prettyPrint: Bool = false) -> Swift.String {
        return serialize(json: json, prettyPrint: prettyPrint, depth: 0).reduce("") {
            $0 + String($1)
        }
    }

    // MARK: - Internal
    
    struct Constant {}

    static func serialize(json json: JSON, prettyPrint: Bool, depth: Int) -> [String.UnicodeScalarView] {
        switch json {
            
        case .Null:
            return serializeNull()
            
        case .Boolean(let boolean):
            return serialize(boolean: boolean)
            
        case .Integer(let integer):
            return serialize(integer: integer)
            
        case .Float(let float):
            return serialize(float: float)

        case .String(let string):
            return serialize(string: string)
            
        case .Array(let elements):
            return serialize(elements: elements, prettyPrint: prettyPrint, depth: depth)
            
        case .Object(let properties):
            return serialize(properties: properties, prettyPrint: prettyPrint, depth: depth)
            
        }
    }

    static func generateIndent(length length: Int) -> String.UnicodeScalarView {
        let space: Character = " "
        return Swift.String(count: 4 * length, repeatedValue: space).unicodeScalars
    }
    
}
