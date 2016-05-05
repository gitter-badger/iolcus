//
//  JSON+Accessors.swift
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

extension JSON {
    
    // MARK: - Array accessor subscript
    
    private func getValue(at index: Swift.Int) -> JSON {
        guard case .Array(let elements) = self else {
            return .Null
        }
        
        guard index >= 0 && index < elements.count else {
            return .Null
        }
        
        return elements[index]
    }
    
    private mutating func setValue(at index: Swift.Int, value newValue: JSON) {
        guard case .Array(let elements) = self else {
            fatalError("`self` is not `.Array`")
        }
        
        var newElements = elements
        newElements[index] = newValue
        
        self = .Array(newElements)
    }
    
    
    /// Subscript-accessor to the elements of a `JSON` array.
    ///
    /// - note: If `self` is not `.Array`, then an attempt to assign value via this accessor will 
    ///         produce a runtime exception.
    ///
    /// - returns: ⁃ If `self` is `.Array`, then this accessor returns an element at the given
    ///              `index` of the array. \
    ///            ⁃ If `index` is out of bounds, then the result is `.Null`. \
    ///            ⁃ If `self` is _not_ `.Array`, then the result is `.Null`.
    public subscript(index: Swift.Int) -> JSON {
        get { return getValue(at: index) }
        set { setValue(at: index, value: newValue) }
    }
    
    // MARK: - Object accessor subscript
    
    private func getValue(at key: Swift.String) -> JSON {
        guard case .Object(let properties) = self else {
            return .Null
        }
        
        return properties[key] ?? .Null
    }
    
    private mutating func setValue(at key: Swift.String, value newValue: JSON) {
        guard case .Object(let properties) = self else {
            fatalError("`self` is not `.Object`")
        }
        
        var newProperties = properties
        newProperties[key] = newValue
        
        self = .Object(newProperties)
    }
    
    
    /// Subscript-accessor to the elements of a `JSON` object (a.k.a. dictionary).
    ///
    /// - note: If `self` is not `.Object`, then an attempt to assign value via this accessor will
    ///         produce a runtime exception.
    ///
    /// - returns: ⁃ If `self` is `.Object`, then this accessor returns an element associated with 
    ///              the given `key`. \
    ///            ⁃ If there is no such `key`, then the result is `.Null`. \
    ///            ⁃ If `self` is _not_ `.Object`, then the result is `.Null`.
    public subscript(key: Swift.String) -> JSON {
        get { return getValue(at: key) }
        set { setValue(at: key, value: newValue) }
    }

    // MARK: - `JSONPathElement` accessor subscript
    
    private func getValue(at pathElement: JSONPathElement) -> JSON {
        switch pathElement {
            
        case .Index(let index):
            return self[index]
            
        case .Key(let key):
            return self[key]
            
        }
    }
    
    private mutating func setValue(at pathElement: JSONPathElement, value newValue: JSON) {
        switch pathElement {
            
        case .Index(let index):
            self[index] = newValue
            
        case .Key(let key):
            self[key] = newValue

        }
    }

    
    /// Combined subscript-accessor to the elements of `JSON` arrays and objects.
    ///
    /// - note: See the description of subscripts for `Int` and `String` for detailed behaviour
    ///         of this subscript (it is a combination of both).
    public subscript(pathElement: JSONPathElement) -> JSON {
        get { return getValue(at: pathElement) }
        set { setValue(at: pathElement, value: newValue) }
    }

    // MARK: - Private accessor for `ArraySlice<JSONPathElement>`
    
    private mutating func setValue(at pathSlice: ArraySlice<JSONPathElement>, value newValue: JSON) {
        if let head = pathSlice.first {
            let tail = pathSlice[(pathSlice.startIndex + 1)..<pathSlice.endIndex]
            var headValue = self[head]
            headValue[tail] = newValue
            self[head] = headValue
        } else {
            self = newValue
        }
    }
    
    private func getValue(at pathSlice: ArraySlice<JSONPathElement>) -> JSON {
        return pathSlice.reduce(self) {
            $0[$1]
        }
    }

    private subscript(pathSlice: ArraySlice<JSONPathElement>) -> JSON {
        get { return getValue(at: pathSlice) }
        set { setValue(at: pathSlice, value: newValue) }
    }

    // MARK: - `JSONPath` accessor subscript
    
    private func getValue(at path: JSONPath) -> JSON {
        return path.reduce(self) {
            $0[$1]
        }
    }
    
    private mutating func setValue(at path: JSONPath, value newValue: JSON) {
        let pathArray = path.map({ $0 })
        let pathSlice = pathArray[pathArray.startIndex..<pathArray.endIndex]
        
        self[pathSlice] = newValue
    }
    
    /// JSON path subscript-accessor.
    ///
    /// Provides read/write access by traversing specified `jsonPath`.
    public subscript(jsonPath: JSONPath) -> JSON {
        get { return getValue(at: jsonPath) }
        set { setValue(at: jsonPath, value: newValue) }
    }
    
}
