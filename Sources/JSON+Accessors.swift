//
//  JSON+Accessors.swift
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
    
    public var booleanValue: Swift.Bool? {
        if case .Boolean(let boolean) = self {
            return boolean
        }
        return nil
    }
    
    public var doubleValue: Swift.Double? {
        if case .Double(let double) = self {
            return double
        }
        return nil
    }
    
    public var intValue: Swift.Int? {
        if case .Integer(let integer) = self {
            return integer
        }
        return nil
    }
    
    public var stringValue: Swift.String? {
        if case .String(let string) = self {
            return string
        }
        return nil
    }
    
    public var arrayElements: [JSON]? {
        if case .Array(let array) = self {
            return array
        }
        return nil
    }
    
    public var objectProperties: [Swift.String: JSON]? {
        if case .Object(let object) = self {
            return object
        }
        return nil
    }
    
}

// MARK: - Subscript accessors

extension JSON {
    
    public subscript(index: Swift.Int) -> JSON {
        if case .Array(let array) = self {
            if index >= 0 && index < array.count {
                return array[index]
            }
        }
        return .Null
    }
    
    public subscript(key: Swift.String) -> JSON {
        if case .Object(let object) = self {
            if let value = object[key] {
                return value
            }
        }
        return .Null
    }
    
}

// MARK: - Wrapped type inspection

extension JSON {
    
    public var isNull: Swift.Bool? {
        switch  self {
        case .Null : return true
        default    : return false
        }
    }
    
    public var isBoolean: Swift.Bool? {
        switch  self {
        case .Boolean(_) : return true
        default          : return false
        }
    }
    
    public var isInteger: Swift.Bool? {
        switch  self {
        case .Integer(_) : return true
        default          : return false
        }
    }
    
    public var isDouble: Swift.Bool? {
        switch  self {
        case .Double(_) : return true
        default         : return false
        }
    }
    
    public var isNumber: Swift.Bool? {
        switch  self {
        case .Integer(_), .Double(_) : return true
        default                      : return false
        }
    }
    
    public var isString: Swift.Bool? {
        switch  self {
        case .String(_) : return true
        default         : return false
        }
    }
    
    public var isArray: Swift.Bool? {
        switch  self {
        case .Array(_) : return true
        default        : return false
        }
    }
    
    public var isObject: Swift.Bool? {
        switch  self {
        case .Object(_) : return true
        default         : return false
        }
    }
    
}

