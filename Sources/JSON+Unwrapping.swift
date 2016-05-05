//
//  JSON+Unwrapping.swift
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
    
    /// Unwrapping accessor to contained `Bool` value.
    ///
    /// - returns: Wrapped `Bool` value in case is `self` is `.Boolean`, `nil` otherwise
    public var unwrappedBoolean: Swift.Bool? {
        guard case .Boolean(let boolean) = self else {
            return nil
        }
        return boolean
    }
    
    /// Unwrapping accessor to contained `Int` value.
    public var unwrappedInteger: Swift.Int? {
        guard case .Integer(let integer) = self else {
            return nil
        }
        return integer
    }
    
    /// Unwrapping accessor to contained `Double` value.
    public var unwrappedDouble: Swift.Double? {
        guard case .Double(let double) = self else {
            return nil
        }
        return double
    }
    
    /// Unwrapping accessor to contained `String` value.
    public var unwrappedString: Swift.String? {
        guard case .String(let string) = self else {
            return nil
        }
        return string
    }
    
}
