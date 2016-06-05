//
//  JSONPath.swift
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

/// A path to the sub-value within a `JSON` value.
public struct JSONPath {
    
    // MARK: - Public API
    
    /// Count of elements in a path.
    public var count: Int {
        return path.count
    }

    /// Creates a path from an array of path elements.
    public init<S: SequenceType where S.Generator.Element == JSONIndex>(path: S) {
        self.path = path.flatMap { $0 }
    }

    /// An element at specific position of the path.
    public subscript(index: Int) -> JSONIndex {
        get {
            return path[index]
        }
        set {
            path[index] = newValue
        }
    }
 
    // MARK: - Internal
    
    var path: [JSONIndex]

}
