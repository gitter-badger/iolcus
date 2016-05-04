//
//  JSONPath.swift
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

public struct JSONPath: SequenceType, ArrayLiteralConvertible, CustomStringConvertible {
    
    private var path: [JSONPathElement]
    
    public var count: Int {
        return path.count
    }
    
    public var first: JSONPathElement? {
        return path.first
    }
    
    public var description: String {
        return path.map({ "[\($0)]" }).joinWithSeparator("")
    }

    public init(elements: [JSONPathElement]) {
        path = elements
    }
    
    public init(elements: ArraySlice<JSONPathElement>) {
        self.init(elements: Array(elements))
    }
    
    public init(elements: JSONPathElement...) {
        self.init(elements: elements)
    }
    
    public init(arrayLiteral elements: JSONPathElement...) {
        self.init(elements: elements)
    }
    
    public subscript(index: Int) -> JSONPathElement {
        get { return path[index] }
        set { path[index] = newValue }
    }
    
    public subscript(subRange: Range<Int>) -> JSONPath {
        return JSONPath(elements: path[subRange])
    }
    
    public func generate() -> IndexingGenerator<[JSONPathElement]> {
        return path.generate()
    }
    
}
