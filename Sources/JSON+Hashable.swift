//
//  JSON+Hashable.swift
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

extension JSON: Hashable {

    private static let hashNull = 0.hashValue
    private static let hashBoolean = 1.hashValue
    private static let hashInteger = 2.hashValue
    private static let hashFloat = 3.hashValue
    private static let hashString = 4.hashValue
    private static let hashArray = 5.hashValue
    private static let hashObject = 6.hashValue

    public var hashValue: Int {
        switch self {
            
        case .Null:
            return JSON.hashNull
            
        case .Boolean(let boolean):
            return JSON.hashBoolean ^ boolean.hashValue
            
        case .Integer(let integer):
            return JSON.hashInteger ^ integer.hashValue
            
        case .Float(let float):
            return JSON.hashFloat ^ float.hashValue
            
        case .String(let string):
            return JSON.hashString ^ string.hashValue
            
        case .Array(let elements):
            return elements.reduce(JSON.hashArray) {
                $0 ^ $1.hashValue
            }
            
        case .Object(let properties):
            return properties.reduce(JSON.hashObject) {
                $0 ^ $1.0.hashValue ^ $1.1.hashValue
            }
            
        }
    }
    
}
