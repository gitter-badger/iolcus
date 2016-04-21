//
//  JSONSerialization.swift
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

public struct JSONSerialization {

    static func serialize(json: JSON) -> [String.UnicodeScalarView] {
        switch json {
            
        case .Null:
            return serialize()
            
        case .Boolean(let boolean):
            return serialize(boolean)
            
        case .Integer(let integer):
            return serialize(integer)
            
        case .Double(let double):
            return serialize(double)

        case .String(let string):
            return serialize(string)
            
        case .Array(let elements):
            return serialize(elements)
            
        case .Object(let properties):
            return serialize(properties)
            
        }
    }
    
    public static func makeString(withJSON json: JSON) -> Swift.String {
        return serialize(json).reduce("") {
            $0 + String($1)
        }
    }
    
}
