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

    /// `JSON.Array` element getter.
    ///
    /// - parameters:
    ///   - at: Integer position of the element in the array.
    ///
    /// - returns: ⁃ `JSON` element "`at`" the specified position of the array.  \
    ///            ⁃ Otherwise, if `self` is not `.Array`, the result is `.Null`. \
    ///            ⁃ Otherwise, if "`at`" index is out of the array's bounds, the result is `.Null`.
    public func getValue(at position: Int) -> JSON {
        guard case .Array(let elements) = self else {
            return .Null
        }
        
        guard position >= 0 && position < elements.count else {
            return .Null
        }

        return elements[position]
    }

    /// `JSON.Array` element setter.
    ///
    /// - parameters:
    ///   - at: Integer position of the element in the array.
    ///   - value: New `JSON` value to put "`at`" the given position of the array.
    ///
    /// - throws: `JSON.Error.Subscrpting` if: \
    ///           ⁃ `self` is not `.Array`. \
    ///           ⁃ `at` index is out of the array's bounds.
    public mutating func setValue(at position: Int, value newValue: JSON) throws {
        guard case .Array(let elements) = self else {
            throw Error.Subscrpting.SettingValueUsingIntegerIndexWithNonArray
        }

        guard position >= 0 && position < elements.count else {
            throw Error.Subscrpting.SettingValueUsingIntegerIndexOutOfBounds
        }

        var newElements = elements
        newElements[position] = newValue
        self = .Array(newElements)
    }

    /// `JSON.Array` subscript accessor.
    ///
    /// - parameters:
    ///   - position: Integer position of the element in the array.
    ///
    /// - throws: Setter throws runtime exception `JSON.Error.Subscrpting` if: \
    ///           ⁃ `self` is not `.Array`. \
    ///           ⁃ `at` index is out of the array's bounds.
    ///
    /// - returns: ⁃ `JSON` element `at` the specified position of the array.  \
    ///            ⁃ Otherwise, if `self` is not `.Array`, the result is `.Null`. \
    ///            ⁃ Otherwise, if "`at`" index is out of the array's bounds, the result is `.Null`.
    public subscript(position: Int) -> JSON {
        get {
            return getValue(at: position)
        }
        set {
            try! setValue(at: position, value: newValue)
        }
    }
    
    // MARK: - `String` subscript

    /// `JSON.Object` property getter.
    ///
    /// - parameters:
    ///   - at: String name of the object's property.
    ///
    /// - returns: ⁃ `JSON` element "`at`" the property with specified name.  \
    ///            ⁃ Otherwise, if `self` is not `.Object`, the result is `.Null`. \
    ///            ⁃ Otherwise, if there is no property "`at`" such name, the result is `.Null`.
    public func getValue(at name: Swift.String) -> JSON {
        guard case .Object(let properties) = self else {
            return .Null
        }
        
        return properties[name] ?? .Null
    }

    /// `JSON.Object` property setter.
    ///
    /// - parameters:
    ///   - at: String name of the object's property.
    ///   - value: New `JSON` value to assign to the object's property "`at`" the given name.
    ///
    /// - throws: Setter throws runtime exception `JSON.Error.Subscrpting` if: \
    ///           ⁃ `self` is not `.Object`.
    public mutating func setValue(at name: Swift.String, value newValue: JSON) throws {
        guard case .Object(let properties) = self else {
            throw JSON.Error.Subscrpting.SettingValueUsingStringIndexWithNonObject
        }
        
        var newProperties = properties
        newProperties[name] = newValue
        
        self = .Object(newProperties)
    }
    
    /// `JSON.Object` subscript accessor.
    ///
    /// - parameters:
    ///   - property: String name of the object's property.
    ///
    /// - throws: Setter throws runtime exception `JSON.Error.Subscrpting` if: \
    ///           ⁃ `self` is not `.Object`.
    ///
    /// - returns: ⁃ `JSON` element "`at`" the property with specified name.  \
    ///            ⁃ Otherwise, if `self` is not `.Object`, the result is `.Null`. \
    ///            ⁃ Otherwise, if there is no property "`at`" such name, the result is `.Null`.
    public subscript(property: Swift.String) -> JSON {
        get {
            return getValue(at: property)
        }
        set {
            try! setValue(at: property, value: newValue)
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
            
        case .Name(let property):
            self[property] = newValue

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
        let pathArray = path.map {
            $0
        }
        let pathSlice = pathArray[pathArray.startIndex..<pathArray.endIndex]
        
        self[pathSlice] = newValue
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
            setValue(at: path, value: newValue)
        }
    }
    
}

// MARK: - Errors

extension JSON.Error {

    /// Exception while using a subscript setter.
    public enum Subscrpting: ErrorType {

        /// Attempted to set the value using an integer index on `JSON` that is not `.Array`.
        case SettingValueUsingIntegerIndexWithNonArray

        /// Attempted to set the value of `JSON.Array` element using the index that is out of bounds.
        case SettingValueUsingIntegerIndexOutOfBounds

        /// Attempted to set value using string index with `JSON` that is not `.Object`.
        case SettingValueUsingStringIndexWithNonObject

    }

}
