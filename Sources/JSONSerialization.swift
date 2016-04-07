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

import Foundation

struct JSONSerialization {
    
    private init() { }
    
}

// MARK: -

extension JSONSerialization {
    
    static func stringWithJSON(json: JSON) -> Swift.String {
        return Swift.String(GeneratorSequence(generatorWithJSON(json)))
    }

    static func sequenceWithJSON(json: JSON) -> AnySequence<Character> {
        return AnySequence(GeneratorSequence(generatorWithJSON(json)))
    }

    static func generatorWithJSON(json: JSON) -> AnyGenerator<Character> {
        switch json {
        case .Null:
            return AnyGenerator(JSONNullSerialization())
        case .Boolean(let boolean):
            return AnyGenerator(JSONBoolSerialization(boolean))
        case .Integer(let integer):
            return AnyGenerator(JSONIntegerSerialization(integer))
        case .Double(let double):
            return AnyGenerator(JSONDoubleSerialization(double))
        case .String(let string):
            return AnyGenerator(JSONStringSerialization(string))
        case .Array(let values):
            return AnyGenerator(JSONArraySerialization(values))
        case .Object(let properties):
            return AnyGenerator(JSONObjectSerialization(properties))
        }
    }

}
