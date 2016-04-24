//
//  JSONDeserialization+Error.swift
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

extension JSON.Error {
    
    /// Error produced while deserializing a `JSON` value.
    public enum Deserialization: ErrorType {
        
        /// Unexpected end of file.
        ///
        /// The stream of input characters for deserializing ended unexpectedly.
        case UnexpectedEOF
        
        /// Unexpected unicode scalar was read.
        ///
        /// - parameters:
        ///   - scalar    : Actual unicode scalar that was encountered.
        ///   - position  : Position of the scalar in the input stream.
        ///                 **Note:** This is a position of a scalar and not character (which will
        ///                           be different.
        case UnexpectedScalar(scalar: UnicodeScalar, position: Swift.Int)
        
        /// Same key was found more than once.
        ///
        /// - parameters:
        ///   - key      : The key that is a duplicate.
        ///   - position : Position of the error.
        case DuplicateObjectKey(key: Swift.String, position: Swift.Int)
        
        /// There was an error while reading the string that constitutes the key.
        ///
        /// - parameters:
        ///   - position : Position of the error.
        case FailedToReadKey(position: Swift.Int)
        
        /// There was an error while reading
        ///
        /// There
        case FailedToReadValue(position: Swift.Int)
        
        /// Failed to read a hex string.
        case FailedToReadHex(hex: Swift.String, position: Swift.Int)
        
        /// Failed to read a number.
        case FailedToReadNumber(number: Swift.String, position: Swift.Int)
        
    }
    
}
