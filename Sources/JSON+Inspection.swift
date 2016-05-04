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
    
    /// Indicates whether the `self` is `.Null`.
    public var isNull: Swift.Bool {
        if self == .Null {
            return true
        }
        return false
    }
    
    /// Indicates whether the `self` is `.Boolean`.
    public var isBoolean: Swift.Bool {
        if case .Boolean(_) = self {
            return true
        }
        return false
    }
    
    /// Indicates whether the `self` is `.Integer`.
    public var isInteger: Swift.Bool {
        if case .Integer(_) = self {
            return true
        }
        return false
    }
    
    /// Indicates whether the `self` is `.Double`.
    public var isDouble: Swift.Bool {
        if case .Double(_) = self {
            return true
        }
        return false
    }
    
    /// Indicates whether the `self` is `.String`.
    public var isString: Swift.Bool {
        if case .String(_) = self {
            return true
        }
        return false
    }
    
    /// Indicates whether the `self` is `.Array`.
    public var isArray: Swift.Bool {
        if case .Array(_) = self {
            return true
        }
        return false
    }
    
    /// Indicates whether the `self` is `.Object`.
    public var isObject: Swift.Bool {
        if case .Object(_) = self {
            return true
        }
        return false
    }
    
}
