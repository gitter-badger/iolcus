//
//  JSON+Coercion.swift
//  Iolcus
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

    /// Coercion of `self` into a boolean value.
    ///
    /// - returns:
    ///   ⁃ If `self` is `.Boolean`, then the result is the wrapped boolean value. \
    ///   ⁃ If `self` is `.Integer` or `.Float`, then the result is `false` when the wrapped value 
    ///     is zero and `true` otherwise. \
    ///   ⁃ If `self` is `.String`, then the result is `true` when the wrapped string equals to
    ///     `"true"`, and `false` if the wrapped string equals to `"false"`.  All other cases
    ///     produce `nil`. \
    ///   ⁃ In all other scenarios the result is `nil`.
    public var coercedBoolean: Bool? {
        switch self {

        case .Null, .Array(_), .Object(_):
            return nil

        case .Boolean(let boolean):
            return boolean

        case .Integer(let integer):
            return (integer != 0)

        case .Float(let float):
            assert(float.isFinite)
            return !float.isZero

        case .String(let string):
            switch string {
            case "true":
                return true
            case "false":
                return false
            default:
                return nil
            }

        }
    }

    /// Coercion of `self` into an integer value.
    ///
    /// - returns:
    ///   ⁃ If `self` is `.Boolean`, then the result is `1` when the wrapped value is `true`, and
    ///     `0` otherwise. \
    ///   ⁃ If `self` is `.Integer`, then the result is just the wrapped `Int` value. \
    ///   ⁃ If `self` is `.Float` and the wrapped value falls within the `Int` range, then the
    ///     result is an integral part of such wrapped value.  In all other cases the result is
    ///     `nil`. \
    ///   ⁃ If `self` is `.String`, then the result is the wrapped `String` value converted into
    ///     `Int`.  If the conversion is not possible then the result is `nil`. \
    ///   ⁃ In all other scenarios the result is `nil`.
    public var coercedInteger: Int? {
        switch self {

        case .Null, .Array(_), .Object(_):
            return nil

        case .Boolean(let boolean):
            return boolean ? 1 : 0

        case .Integer(let integer):
            return integer

        case .Float(let float):
            if float >= Double(Int.min) && float <= Double(Int.max) {
                return Int(float)
            } else {
                return nil
            }

        case .String(let string):
            return Int(string)

        }
    }

    /// Coercion of `self` into a floating-point value.
    ///
    /// - returns:
    ///   ⁃ If `self` is `.Boolean`, then the result is `1.0` if the wrapped value is `true`,
    ///     `0.0` otherwise. \
    ///   ⁃ If `self` is `.Integer`, then the result is the wrapped integer value converted into a
    ///     floating point.  Beware of side-effects of such conversions.E.g. 64-bit
    ///     `Int(9223372036854774807)` might convert into `Double(9223372036854774784)`. \
    ///   ⁃ If `self` is `.Float`, then it returns the wrapped floating-point value. \
    ///   ⁃ If `self` is `.String`, then it converts wrapped string into a floating-point value, 
    ///     or returns `nil` if the conversion is not possible. \
    ///   ⁃ In all other scenarios the result is `nil`.
    public var coercedFloat: Double? {
        switch self {

        case .Null, .Array(_), .Object(_):
            return nil

        case .Boolean(let boolean):
            return boolean ? 1.0 : 0.0

        case .Integer(let integer):
            return Double(integer)

        case .Float(let float):
            return float

        case .String(let string):
            return Double(string)

        }
    }

    /// Attempts to coerce `self` into a string value.
    ///
    /// - returns:
    ///   ⁃ If `self` is `.Null`, then result is `"null"`. \
    ///   ⁃ If `self` is `.Boolean`, then the result is `"true"` or `"false"` depending on the
    ///     wrapped boolean value.  \
    ///   ⁃ If `self` is `.Integer` or `.Float`, then the result is a string` representation of
    ///     the wrapped number. \
    ///   ⁃ If `self` is `.String`, then it returns a wrapped string value. \
    ///   ⁃ In all other scenarios the result is `nil`.
    public var coercedString: Swift.String? {
        switch self {

        case .Null:
            return "null"

        case .Boolean(let boolean):
            return Swift.String(boolean)

        case .Integer(let integer):
            return Swift.String(integer)

        case .Float(let float):
            return Swift.String(float)

        case .String(let string):
            return string

        case .Array(_), .Object(_):
            return nil
            
        }
    }
    
}
