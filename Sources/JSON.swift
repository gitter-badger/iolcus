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

// MARK: JSON

/// JSON value.
public indirect enum JSON: Equatable {
    
    case Null
    case Boolean(Swift.Bool)
    case Integer(Swift.Int)
    case Double(Swift.Double)
    case String(Swift.String)
    case Array([JSON])
    case Object([Swift.String: JSON])
    
    public struct Error { }
    
}

// MARK: - Equatable

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

// MARK: - Hashable

extension JSON: Hashable {
    
    public var hashValue: Int {
        switch self {
            
        case .Null:
            return 0.hashValue
            
        case .Boolean(let boolean):
            return 1.hashValue ^ boolean.hashValue
            
        case .Integer(let integer):
            return 2.hashValue ^ integer.hashValue
            
        case .Double(let double):
            return 3.hashValue ^ double.hashValue
            
        case .String(let string):
            return 4.hashValue ^ string.hashValue
            
        case .Array(let elements):
            return elements.reduce(5.hashValue) {
                $0 ^ $1.hashValue
            }
            
        case .Object(let properties):
            return properties.reduce(6.hashValue) {
                $0 ^ $1.0.hashValue ^ $1.1.hashValue
            }

        }
    }
    
}
