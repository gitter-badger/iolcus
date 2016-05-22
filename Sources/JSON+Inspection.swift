//
//  JSON+Inspection.swift
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
    
    /// Indicates whether `self` is null.
    public var isNull: Bool {
        if self == .Null {
            return true
        }
        return false
    }
    
    /// Indicates whether `self` is a boolean.
    public var isBoolean: Bool {
        if case .Boolean(_) = self {
            return true
        }
        return false
    }
    
    /// Indicates whether the `self` is an integer number.
    public var isInteger: Bool {
        if case .Integer(_) = self {
            return true
        }
        return false
    }
    
    /// Indicates whether the `self` is a floating-point number.
    public var isFloat: Bool {
        if case .Float(_) = self {
            return true
        }
        return false
    }

    /// Indicates whether the `self` is a number.
    public var isNumber: Bool {
        return isInteger || isFloat
    }
    
    /// Indicates whether `self` is string.
    public var isString: Bool {
        if case .String(_) = self {
            return true
        }
        return false
    }
    
    /// Indicates whether `self` is array.
    public var isArray: Bool {
        if case .Array(_) = self {
            return true
        }
        return false
    }
    
    /// Indicates whether `self` is object.
    public var isObject: Bool {
        if case .Object(_) = self {
            return true
        }
        return false
    }
    
}
