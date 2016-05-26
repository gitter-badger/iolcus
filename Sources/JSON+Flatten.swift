//
//  JSON+Flatten.swift
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

    // MARK: - Public API

    /// Flattens `self` into an array of `(JSONPath, JSON)` pairs.
    ///
    /// - returns: An array of `(path: JSONPath, json: JSON)` tuples. \
    ///   ⁃ `path` : shows a path that has to be traversed in order to get to each particular
    ///              `json` value. \
    ///   ⁃ `json` : is basic non-container `JSON` sub-element of `self` (that is, `.Null`, 
    ///              `.Boolean`, `.Integer`, `.Float` or `.String`).
    public func flatten() -> [(path: JSONPath, json: JSON)] {
        return reversePathEnumeration().map {
            (JSONPath(path: $0.reverse()), $1)
        }
    }

    // MARK: - Internal

    private func reversePathEnumeration() -> [(reversePath: [JSONIndex], json: JSON)] {
        switch self {

        case .Null, .Boolean(_), .Integer(_), .Float(_), .String(_):
            return [([], self)]

        case .Array(let elements):
            return elements.enumerate().flatMap {
                (position: Int, element: JSON) -> [(reversePath: [JSONIndex], json: JSON)] in

                let suffix = JSONIndex.Position(position)
                return element.reversePathEnumeration().map {
                    (reversePath: [JSONIndex], json: JSON) -> (reversePath: [JSONIndex], json: JSON) in

                    var reversePathWithSuffix = reversePath
                    reversePathWithSuffix.append(suffix)
                    return (reversePathWithSuffix, json)
                }
            }

        case .Object(let properties):
            return properties.flatMap {
                (name: Swift.String, element: JSON) -> [(reversePath: [JSONIndex], json: JSON)] in

                let suffix = JSONIndex.Name(name)
                return element.reversePathEnumeration().map {
                    (reversePath: [JSONIndex], json: JSON) -> (reversePath: [JSONIndex], json: JSON) in

                    var reversePathWithSuffix = reversePath
                    reversePathWithSuffix.append(suffix)
                    return (reversePathWithSuffix, json)
                }
            }

        }
    }
}
