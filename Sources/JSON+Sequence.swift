//
//  JSON+Sequence.swift
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

extension JSON: SequenceType {
    
    public func generate() -> AnyGenerator<(key: Swift.String, json: JSON)> {
        switch  self {
            
        case .Null, .Boolean(_), .Integer(_), .Double(_), .String(_):
            let generator = GeneratorOfOne(("", self))
            return AnyGenerator(generator)
            
        case .Array(let elements):
            let generator = elements.enumerate().map({(Swift.String($0), $1)}).generate()
            return AnyGenerator(generator)
            
        case .Object(let properties):
            let generator = properties.generate()
            return AnyGenerator(generator)
            
        }
    }
    
}
