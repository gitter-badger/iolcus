//
//  JSONGenerator.swift
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

public struct JSONGenerator: GeneratorType {
    
    public typealias Element = (index: JSONIndex, json: JSON)
    
    private let wrappedNext: Void -> Element?
    
    init(json: JSON) {
        switch json {
            
        case .Null, .Boolean(_), .Integer(_), .Float(_), .String(_):
            let wrappedSequence = (JSONIndex.This, json)
            var wrappedGenerator = GeneratorOfOne(wrappedSequence)
            wrappedNext = { wrappedGenerator.next() }
            
        case .Array(let elements):
            let wrappedSequence = elements.enumerate().map {
                (JSONIndex.Index($0), $1)
            }
            var wrappedGenerator = wrappedSequence.generate()
            wrappedNext = { wrappedGenerator.next() }
            
        case .Object(let properties):
            let wrappedSequence = properties.map {
                (JSONIndex.Key($0), $1)
            }
            var wrappedGenerator = wrappedSequence.generate()
            wrappedNext = { wrappedGenerator.next() }
            
        }
    }
    
    public mutating func next() -> Element? {
        return wrappedNext()
    }
    
}
