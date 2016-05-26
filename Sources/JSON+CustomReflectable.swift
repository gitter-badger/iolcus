//
//  JSON+CustomReflectable.swift
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

extension JSON: CustomReflectable {
    
    private static let null: Void? = nil
    
    public func customMirror() -> Mirror {
        switch self {
            
        case .Null:
            let children: [(Swift.String?, Any)] = [(nil, JSON.null)]
            return Mirror(self, children: children, displayStyle: .Set)
            
        case .Boolean(let boolean):
            let children: [(Swift.String?, Any)] = [(nil, boolean)]
            return Mirror(self, children: children, displayStyle: .Set)
            
        case .Integer(let integer):
            let children: [(Swift.String?, Any)] = [(nil, integer)]
            return Mirror(self, children: children, displayStyle: .Set)
            
        case .Float(let float):
            let children: [(Swift.String?, Any)] = [(nil, float)]
            return Mirror(self, children: children, displayStyle: .Set)
            
        case .String(let string):
            let children: [(Swift.String?, Any)] = [(nil, string)]
            return Mirror(self, children: children, displayStyle: .Set)
            
        case .Array(let elements):
            return Mirror(self, unlabeledChildren: elements, displayStyle: .Collection)
            
        case .Object(let properties):
            let children: [(Swift.String?, Any)] = properties.map { (key: Swift.String, json: JSON) -> (Swift.String?, Any) in
                switch json {

                case .Null:
                    return ("\"\(key)\"", JSON.null)

                case .Boolean(let boolean):
                    return ("\"\(key)\"", boolean)

                case .Integer(let integer):
                    return ("\"\(key)\"", integer)

                case .Float(let float):
                    return ("\"\(key)\"", float)

                case .String(let string):
                    return ("\"\(key)\"", string)

                case .Array(let elements):
                    return ("\"\(key)\"", elements)

                case .Object(let properties):
                    return ("\"\(key)\"", properties)
                    
                }
            }
            return Mirror(self, children: children, displayStyle: .Dictionary)
            
        }
    }
    
}
