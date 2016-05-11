//
//  JSON+Coercion.swift
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

    /// Attempts to coerce `self` into a `Bool` value.
    ///
    /// - returns: 
    ///   ⁃ If `self` is `.Boolean`, then the result is a wrapped `Bool` value. \
    ///   ⁃ If `self` is `.Integer` or `.Double`, then it returns `true` if the wrapped value is 
    ///     non-zero, `false` otherwise. \
    ///   ⁃ If `self` is `.String`, then the result is `true` if the wrapped string equals to 
    ///     `"true"`, and `false` if the wrapped string equals to `"false"`.  All other cases 
    ///     produce `nil`. \
    ///   ⁃ In all other scenarios the result is `nil`.
    public var coercedBoolean: Swift.Bool? {
        switch self {
            
        case .Null, .Array(_), .Object(_):
            return nil
            
        case .Boolean(let boolean):
            return boolean
            
        case .Integer(let integer):
            return (integer != 0)
            
        case .Double(let double):
            return (double != 0.0)
            
        case .String(let string):
            if string == "true" {
                return true
            } else if string == "false" {
                return false
            } else {
                return nil
            }
            
        }
    }
    
    /// Attempts to coerce `self` into an `Int` value.
    ///
    /// - returns:
    ///   ⁃ If `self` is `.Boolean`, then the result is `1` if the wrapped value is `true`, `0`
    ///     otherwise. \
    ///   ⁃ If `self` is `.Integer`, then it returns a wrapped `Int` value. \
    ///   ⁃ If `self` is `.Double`, and wrapped value falls within the `Int` range, then the result 
    ///     is an integral part of such wrapped value.  In all other cases the result is `nil`. \
    ///   ⁃ If `self` is `.String`, then it converts wrapped `String` into an `Int`, or returns 
    ///     `nil` if the conversion is not possible. \
    ///   ⁃ In all other scenarios the result is `nil`.
    public var coercedInteger: Swift.Int? {
        switch self {
            
        case .Null, .Array(_), .Object(_):
            return nil

        case .Boolean(let boolean):
            return boolean ? 1 : 0
            
        case .Integer(let integer):
            return integer
            
        case .Double(let double):
            if double >= Swift.Double(Swift.Int.min) && double <= Swift.Double(Swift.Int.max) {
                return Swift.Int(double)
            } else {
                return nil
            }
            
        case .String(let string):
            return Swift.Int(string)
        
        }
    }
    
    /// Attempts to coerce `self` into an `Double` value.
    ///
    /// - returns:
    ///   ⁃ If `self` is `.Boolean`, then the result is `1.0` if the wrapped value is `true`,
    ///     `0.0` otherwise. \
    ///   ⁃ If `self` is `.Integer`, then the result is the wrapped `Int` value converted into a
    ///     `Double`.  Beware of side-effects of Int->Double conversions.  E.g. 64-bit
    ///     `Int(9223372036854774807)` might convert into `Double(9223372036854774784)`. \
    ///   ⁃ If `self` is `.Double`, then it returns a wrapped `Double` value. \
    ///   ⁃ If `self` is `.String`, then it converts wrapped `String` into a `Double`, or returns
    ///     `nil` if the conversion is not possible. \
    ///   ⁃ In all other scenarios the result is `nil`.
    public var coercedDouble: Swift.Double? {
        switch self {

        case .Null, .Array(_), .Object(_):
            return nil

        case .Boolean(let boolean):
            return boolean ? 1.0 : 0.0
            
        case .Integer(let integer):
            return Swift.Double(integer)

        case .Double(let double):
            return double
            
        case .String(let string):
            return Swift.Double(string)

        }
    }
    
    /// Attempts to coerce `self` into a `String` value.
    ///
    /// - returns:
    ///   ⁃ If `self` is `.Null`, then result is `"null"`. \
    ///   ⁃ If `self` is `.Boolean`, then the result is `"true"` or `"false"` correspondingly.  \
    ///   ⁃ If `self` is `.Integer` or `.Double`, then the result is a `String` representation of 
    ///     the wrapped number. \
    ///   ⁃ If `self` is `.String`, then it returns a wrapped `String` value. \
    ///   ⁃ In all other scenarios the result is `nil`.
    public var coercedString: Swift.String? {
        switch self {
            
        case .Null:
            return "null"
            
        case .Boolean(let boolean):
            return Swift.String(boolean)
            
        case .Integer(let integer):
            return Swift.String(integer)
            
        case .Double(let double):
            return Swift.String(double)
            
        case .String(let string):
            return string
            
        case .Array(_), .Object(_):
            return nil

        }
    }
    
}
