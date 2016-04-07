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

/// JSON value.
public indirect enum JSON {
    
    case Null
    case Boolean(Swift.Bool)
    case Integer(Swift.Int)
    case Double(Swift.Double)
    case String(Swift.String)
    case Array([JSON])
    case Object([Swift.String: JSON])
    
    /// Exception produced while manipulating JSON value
    public struct Exception {
        
        /// Exception produced while serializing JSON value
        public enum Serializing: ErrorType {
            case UnexpectedEOF
            case UnexpectedCharacter(character: Swift.Character, position: Swift.Int)
            case DuplicateObjectKey(key: Swift.String, position: Swift.Int)
            case FailedToReadKey(position: Swift.Int)
            case FailedToReadValue(position: Swift.Int)
            case FailedToReadHex(hex: Swift.String, position: Swift.Int)
            case FailedToReadNumber(number: Swift.String, position: Swift.Int)
            case FailedToReadNSJSON(type: Any.Type)
        }
        
        /// Exception produced while decoding a value from JSON
        public enum Decoding: ErrorType {
            case FailedToDecode(type: Any.Type, json: JSON)
        }
        
    }
    
    struct Constants { }
    
}

// MARK: - Equatable

extension JSON: Equatable { }

public func == (lhs: JSON, rhs: JSON) -> Swift.Bool {
    switch (lhs, rhs) {
    case (.Null, .Null):
        return true
    case (.Boolean(let lhsBoolean), .Boolean(let rhsBoolean)):
        return lhsBoolean == rhsBoolean
    case (.Integer(let lhsInt), .Integer(let rhsInt)):
        return lhsInt == rhsInt
    case (.Double(let lhsDouble), .Double(let rhsDouble)):
        return lhsDouble == rhsDouble
    case (.String(let lhsString), .String(let rhsString)):
        return lhsString == rhsString
    case (.Array(let lhsArray), .Array(let rhsArray)):
        return lhsArray.count == rhsArray.count
            && !zip(lhsArray, rhsArray).contains(!=)
    case (.Object(let lhsObject), .Object(let rhsObject)):
        return lhsObject.count == rhsObject.count
            && !lhsObject.contains() {
                rhsObject[$0] != $1
        }
    default:
        return false
    }
    
}

// MARK: - CustomStringConvertible

extension JSON: CustomStringConvertible {
    
    public var description: Swift.String {
        return JSONSerialization.stringWithJSON(self)
    }
    
}
