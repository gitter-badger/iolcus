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

// MARK: Wrapped value accessors

extension JSON {
    
    /// `Bool` representation of the wrapped value.
    public var boolean: Swift.Bool? {
        get {
            if case .Boolean(let boolean) = self {
                return boolean
            }
            return nil
        }
        set {
            if let boolean = newValue {
                self = .Boolean(boolean)
            } else {
                self = .Null
            }
        }
    }
    
    /// `Int` representation of the wrapped value.
    public var integer: Swift.Int? {
        get {
            if case .Integer(let integer) = self {
                return integer
            }
            return nil
        }
        set {
            if let integer = newValue {
                self = .Integer(integer)
            } else {
                self = .Null
            }
        }
    }

    /// `Double` representation of the wrapped value.
    public var double: Swift.Double? {
        get {
            if case .Double(let double) = self {
                return double
            }
            return nil
        }
        set {
            if let double = newValue {
                self = .Double(double)
            } else {
                self = .Null
            }
        }
    }
    
    /// `String` representation of the wrapped value.
    public var string: Swift.String? {
        get {
            if case .String(let string) = self {
                return string
            }
            return nil
        }
        set {
            if let string = newValue {
                self = .String(string)
            } else {
                self = .Null
            }
        }
    }
    
    /// `[JSON]` array representation of the wrapped value.
    public var array: [JSON]? {
        get {
            if case .Array(let array) = self {
                return array
            }
            return nil
        }
        set {
            if let elements = newValue {
                self = .Array(elements)
            } else {
                self = .Null
            }
        }
    }
    
    /// `[String: JSON]` properties dictionary representation of the wrapped value.
    public var object: [Swift.String: JSON]? {
        get {
            if case .Object(let object) = self {
                return object
            }
            return nil
        }
        set {
            if let properties = newValue {
                self = .Object(properties)
            } else {
                self = .Null
            }
        }
    }
    
}

// MARK: - Subscript accessors

extension JSON {
    
    /// Shorthand accessor for elements of the `JSON` array.
    ///
    /// - returns: If a particular `JSON` is `.Array` then this subsript will return a particular element corresponding to the `index`.
    ///            In all other cases the subscript returns `.Null`.  
    ///            If the `index` is out of bounds the subscript will also return `.Null`.
    public subscript(index: Swift.Int) -> JSON {
        get {
            if case .Array(let elements) = self {
                if index >= 0 && index < elements.count {
                    return elements[index]
                }
            }
            return .Null
        }
        set {
            if case .Array(let elements) = self {
                var newElements = elements
                newElements[index] = newValue
                self = .Array(newElements)
            } else {
                fatalError("This JSON is not .Array")
            }
        }
    }
    
    /// Shorthand accessor for elements of the `JSON` object (a.k.a. dictionary).
    ///
    /// - returns: If a particular `JSON` is `.Object` then this subsript will return a particular element corresponding to the `key`.
    ///            In all other cases the subscript returns `.Null`.
    ///            If there is no element with such `key` then the subscript also returns `.Null`.
    public subscript(key: Swift.String) -> JSON {
        get {
            if case .Object(let properties) = self {
                if let value = properties[key] {
                    return value
                }
            }
            return .Null
        }
        set {
            if case .Object(let properties) = self {
                var newProperties = properties
                newProperties[key] = newValue
                self = .Object(newProperties)
            } else {
                fatalError("This JSON is not .Object")
            }
        }
    }
    
}

// MARK: - Wrapped type inspection

extension JSON {
    
    /// Indicates whether the `JSON` value is null.
    public var isNull: Swift.Bool {
        switch  self {
        case .Null : return true
        default    : return false
        }
    }
    
    /// Indicates whether the `JSON` value is boolean.
    public var isBoolean: Swift.Bool {
        switch  self {
        case .Boolean(_) : return true
        default          : return false
        }
    }
    
    /// Indicates whether the `JSON` value is an integer.
    public var isInteger: Swift.Bool {
        switch  self {
        case .Integer(_) : return true
        default          : return false
        }
    }
    
    /// Indicates whether the `JSON` value is double (floating point).
    public var isDouble: Swift.Bool {
        switch  self {
        case .Double(_) : return true
        default         : return false
        }
    }
    
    /// Indicates whether the `JSON` value a number (either integer or double).
    public var isNumber: Swift.Bool {
        switch  self {
        case .Integer(_), .Double(_) : return true
        default                      : return false
        }
    }
    
    /// Indicates whether the `JSON` value is a string.
    public var isString: Swift.Bool {
        switch  self {
        case .String(_) : return true
        default         : return false
        }
    }
    
    /// Indicates whether the `JSON` value is an array.
    public var isArray: Swift.Bool {
        switch  self {
        case .Array(_) : return true
        default        : return false
        }
    }
    
    /// Indicates whether the `JSON` value is an object.
    public var isObject: Swift.Bool {
        switch  self {
        case .Object(_) : return true
        default         : return false
        }
    }
    
}

