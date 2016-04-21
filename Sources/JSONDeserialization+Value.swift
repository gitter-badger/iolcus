//
//  JSONDeserialization+Value.swift
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

extension JSONDeserialization {

    mutating func deserializeValue() throws -> JSON {
        let scalar = try peekScalar()

        switch scalar {
        
        case Constant.nullOpeningScalar:
            return try deserializeNull()

        case Constant.booleanTrueOpeningScalar:
            return try deserializeTrue()
            
        case Constant.booleanFalseOpeningScalar:
            return try deserializeFalse()
            
        case Constant.numberOpeningScalars:
            return try deserializeNumber()

        case Constant.stringOpeningScalar:
            return try deserializeString()
        
        case Constant.arrayOpeningScalar:
            return try deserializeArray()
        
        case Constant.objectOpeningScalar:
            return try deserializeObject()
        
        default:
            break
        
        }

        throw Error.Deserializing.UnexpectedScalar(scalar: scalar, position: position)
    }

}
