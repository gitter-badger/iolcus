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

    // MARK: - `Int` subscript

    private func getValue(at position: Swift.Int) -> JSON {
        guard case .Array(let elements) = self else {
            return .Null
        }
        
        guard position >= 0 && position < elements.count else {
            return .Null
        }

        return elements[position]
    }
    
    private mutating func setValue(at position: Swift.Int, value newValue: JSON) {
        guard case .Array(let elements) = self else {
            fatalError("`self` is not `.Array`")
        }

        var newElements = elements
        newElements[position] = newValue

        self = .Array(elements: newElements)
    }

    /// `Int` subscript.  Suitable for `JSON.Array`.
    ///
    /// - note: If `self` is not `.Array`, then this subscript's setter produces runtime exception 
    ///         (getter simply returns `.Null` value).
    ///
    /// - returns: ⁃ If `self` is `.Array`, then this accessor returns an element at the given
    ///              `position` of the array. \
    ///            ⁃ If `position` is out of bounds, then the result is `.Null`. \
    ///            ⁃ If `self` is _not_ `.Array`, then the result is `.Null`.
    public subscript(position: Swift.Int) -> JSON {
        get {
            return getValue(at: position)
        }
        set {
            setValue(at: position, value: newValue)
        }
    }
    
    // MARK: - `String` subscript

    private func getValue(at name: Swift.String) -> JSON {
        guard case .Object(let properties) = self else {
            return .Null
        }
        
        return properties[name] ?? .Null
    }
    
    private mutating func setValue(at name: Swift.String, value newValue: JSON) {
        guard case .Object(let properties) = self else {
            fatalError("`self` is not `.Object`")
        }
        
        var newProperties = properties
        newProperties[name] = newValue
        
        self = .Object(properties: newProperties)
    }
    
    /// `String` subscript.  Suitable for `JSON.Object`.
    ///
    /// - note: If `self` is not `.Object`, then this subscript's setter produces runtime exception
    ///         (getter simply returns `.Null` value).
    ///
    /// - returns: ⁃ If `self` is `.Object`, then this accessor returns an element associated with
    ///              the given property `name`. \
    ///            ⁃ If there is no such property `name`, then the result is `.Null`. \
    ///            ⁃ If `self` is _not_ `.Object`, then the result is `.Null`.
    public subscript(name: Swift.String) -> JSON {
        get {
            return getValue(at: name)
        }
        set {
            setValue(at: name, value: newValue)
        }
    }

    // MARK: - `JSONIndex` subscript.
    
    private func getValue(at index: JSONIndex) -> JSON {
        switch index {

        case .This:
            return self
            
        case .Position(let position):
            return self[position]

        case .Name(let name):
            return self[name]
            
        }
    }
    
    private mutating func setValue(at index: JSONIndex, value newValue: JSON) {
        switch index {
            
        case .This:
            self = newValue

        case .Position(let position):
            self[position] = newValue
            
        case .Name(let name):
            self[name] = newValue

        }
    }

    /// `JSONIndex` subscript.
    public subscript(index: JSONIndex) -> JSON {
        get {
            return getValue(at: index)
        }
        set {
            setValue(at: index, value: newValue)
        }
    }

    // MARK: - `ArraySlice<JSONIndex>` subscript.
    
    private mutating func setValue(at path: ArraySlice<JSONIndex>, value newValue: JSON) {
        if let head = path.first {
            let tail = path[(path.startIndex + 1)..<path.endIndex]
            var headValue = self[head]
            headValue[tail] = newValue
            self[head] = headValue
        } else {
            self = newValue
        }
    }

    private func getValue(at pathSlice: ArraySlice<JSONIndex>) -> JSON {
        return pathSlice.reduce(self) {
            $0[$1]
        }
    }

    private subscript(pathSlice: ArraySlice<JSONIndex>) -> JSON {
        get {
            return getValue(at: pathSlice)
        }
        set {
            setValue(at: pathSlice, value: newValue)
        }
    }

    // MARK: - `JSONPath` subscript.
    
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

    /// `JSONPath` subscript.
    public subscript(path: JSONPath) -> JSON {
        get {
            return getValue(at: path)
        }
        set {
            setValue(at: path, value: newValue)
        }
    }
    
}
