//
//  JSONDeserialization+Number.swift
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

extension JSONDeserialization {

    mutating func deserializeNumber() throws -> JSON {
        var scalars = String.UnicodeScalarView()
        scalars.reserveCapacity(16)
        
        readLoop: while !eof() {
            let scalar = try peekScalar()
            
            if !Constant.numberScalars.contains(scalar) {
                break readLoop
            }

            scalars.append(scalar)
            skipPeekedScalar()
        }
        
        let string = String(scalars)
        
        if let integer = Int(string) {
            return JSON.Integer(integer)
        }
        
        if let float = Double(string) where float.isFinite {
            return JSON.Float(float)
        }
        
        throw JSON.Error.Deserializing.FailureInterpretingNumber(number: string, position: position)
    }

}
