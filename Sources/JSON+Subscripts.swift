//
//  JSON+Accessors.swift
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

extension JSON {

    // MARK: - `Void` subscript

    func getArray() -> [JSON] {
        guard case .Array(let elements) = self else {
            return [self]
        }

        return elements
    }

    mutating func setArray(value newValue: [JSON]) {
        self = .Array(newValue)
    }

    /// `JSON.Array` subscript.
    ///
    /// - Returns: ⁃ `self` if `self` is `.Array` \
    ///            ⁃ `.Array([self])` otherwise
    public subscript() -> [JSON] {
        get {
            return getArray()
        }
        set {
            setArray(value: newValue)
        }
    }

    // MARK: - `Int` subscript

    /// `JSON.Array` element getter.
    ///
    /// - Parameters:
    ///   - at: Integer position of the element in the array.
    ///
    /// - Returns: ⁃ `JSON` element `at` the specified index.  \
    ///            ⁃ Otherwise, if `self` is not `.Array`, the result is `.Null`. \
    ///            ⁃ Otherwise, if `at` index is out of the array's bounds, the result is `.Null`.
    public func getValue(at index: Int) -> JSON {
        guard case .Array(let elements) = self else {
            return .Null
        }
        
        guard index >= 0 && index < elements.count else {
            return .Null
        }

        return elements[index]
    }

    /// `JSON.Array` element setter.
    ///
    /// - Precondition: `self == .Array(_)`
    ///
    /// - Parameters:
    ///   - at: Integer position of the element in the array.
    ///   - value: New `JSON` value to put `at` the given index.
    ///
    /// - Throws: `JSON.Error.Subscripting` if: \
    ///           ⁃ `self` is not `.Array`. \
    ///           ⁃ `at` index is out of the array's bounds.
    public mutating func setValue(at index: Int, value newValue: JSON) throws {
        guard case .Array(let elements) = self else {
            throw Error.Subscripting.FailedToIndexNonArray
        }

        guard index >= 0 && index < elements.count else {
            throw Error.Subscripting.IndexOutOfBounds
        }

        var newElements = elements
        newElements[index] = newValue
        self = .Array(newElements)
    }

    /// `JSON.Array` subscript accessor.
    ///
    /// - Parameters:
    ///   - position: Integer position of the element in the array.
    ///
    /// - Throws: Setter throws runtime exception `JSON.Error.Subscripting` if: \
    ///           ⁃ `self` is not `.Array`. \
    ///           ⁃ `at` index is out of the array's bounds.
    ///
    /// - Returns: ⁃ `JSON` element `at` the specified position of the array.  \
    ///            ⁃ Otherwise, if `self` is not `.Array`, the result is `.Null`. \
    ///            ⁃ Otherwise, if "`at`" index is out of the array's bounds, the result is `.Null`.
    public subscript(index: Int) -> JSON {
        get {
            return getValue(at: index)
        }
        set {
            try! setValue(at: index, value: newValue)
        }
    }

    // MARK: - `String` subscript

    /// `JSON.Object` property getter.
    ///
    /// - Parameters:
    ///   - at: String name of the object's property.
    ///
    /// - Returns: ⁃ `JSON` element `at` the specified key.  \
    ///            ⁃ Otherwise, if `self` is not `.Object`, the result is `.Null`. \
    ///            ⁃ Otherwise, if there is no property `at` such key, the result is `.Null`.
    public func getValue(at key: Swift.String) -> JSON {
        guard case .Object(let properties) = self else {
            return .Null
        }
        
        return properties[key] ?? .Null
    }

    /// `JSON.Object` property setter.
    ///
    /// - Precondition: `self == .Object(_)`
    ///
    /// - Parameters:
    ///   - at: String name of the object's property.
    ///   - value: New `JSON` value to assign to the object's property `at` the given key.
    ///
    /// - Throws: Setter throws runtime exception `JSON.Error.Subscripting` if: \
    ///           ⁃ `self` is not `.Object`.
    public mutating func setValue(at key: Swift.String, value newValue: JSON) throws {
        guard case .Object(let properties) = self else {
            throw JSON.Error.Subscripting.FailedToKeyNonObject
        }
        
        var newProperties = properties
        newProperties[key] = newValue
        
        self = .Object(newProperties)
    }
    
    /// `JSON.Object` subscript accessor.
    ///
    /// - Parameters:
    ///   - key: String name of the object's property.
    ///
    /// - Throws: Setter throws runtime exception `JSON.Error.Subscripting` if: \
    ///           ⁃ `self` is not `.Object`.
    ///
    /// - Returns: ⁃ `JSON` element `at` the specified key.  \
    ///            ⁃ Otherwise, if `self` is not `.Object`, the result is `.Null`. \
    ///            ⁃ Otherwise, if there is no property `at` such key, the result is `.Null`.
    public subscript(key: Swift.String) -> JSON {
        get {
            return getValue(at: key)
        }
        set {
            try! setValue(at: key, value: newValue)
        }
    }

    // MARK: - `JSONIndex` subscript.
    
    private func getValue(at index: JSONIndex) -> JSON {
        switch index {

        case .This:
            return self
            
        case .Index(let index):
            return self.getValue(at: index)

        case .Key(let key):
            return self.getValue(at: key)
            
        }
    }
    
    private mutating func setValue(at index: JSONIndex, value newValue: JSON) throws {
        switch index {
            
        case .This:
            self = newValue

        case .Index(let index):
            try self.setValue(at: index, value: newValue)
            
        case .Key(let key):
            try self.setValue(at: key, value: newValue)

        }
    }

    /// `JSONIndex` subscript accessor.
    ///
    /// Maps either to integer accessor to `JSON.Array` or to string accessor ot `JSON.Object`.
    public subscript(index: JSONIndex) -> JSON {
        get {
            return getValue(at: index)
        }
        set {
            try! setValue(at: index, value: newValue)
        }
    }

    // MARK: - `ArraySlice<JSONIndex>` subscript.
    
    private func getValue(at slice: ArraySlice<JSONIndex>) -> JSON {
        return slice.reduce(self) {
            $0.getValue(at: $1)
        }
    }

    private mutating func setValue(at slice: ArraySlice<JSONIndex>, value newValue: JSON) throws {
        if let head = slice.first {
            let tail = slice[(slice.startIndex + 1)..<slice.endIndex]
            var headValue = self.getValue(at: head)
            try headValue.setValue(at: tail, value: newValue)
            try self.setValue(at: head, value: headValue)
        } else {
            self = newValue
        }
    }

    private subscript(slice: ArraySlice<JSONIndex>) -> JSON {
        get {
            return getValue(at: slice)
        }
        set {
            try! setValue(at: slice, value: newValue)
        }
    }

    // MARK: - `JSONPath` subscript.
    
    private func getValue(at path: JSONPath) -> JSON {
        return path.reduce(self) {
            $0.getValue(at: $1)
        }
    }

    private mutating func setValue(at path: JSONPath, value newValue: JSON) throws {
        let pathArray = path.map {
            $0
        }
        let pathSlice = pathArray[pathArray.startIndex..<pathArray.endIndex]
        try self.setValue(at: pathSlice, value: newValue)
    }

    /// `JSONPath` subscript accessor.
    ///
    /// Provides get/set access to the `JSON` sub-element at specific path of integer/string 
    /// indexes (array/object).
    public subscript(path: JSONPath) -> JSON {
        get {
            return getValue(at: path)
        }
        set {
            try! setValue(at: path, value: newValue)
        }
    }

}

// MARK: - Errors

extension JSON.Error {

    /// Exception while using a subscript setter.
    public enum Subscripting: ErrorType {

        /// Attempted to set the value using an integer index on `JSON` that is not `.Array`.
        case FailedToIndexNonArray

        /// Attempted to set the value of `JSON.Array` element using the index that is out of bounds.
        case IndexOutOfBounds

        /// Attempted to set value using string index with `JSON` that is not `.Object`.
        case FailedToKeyNonObject

    }

}
