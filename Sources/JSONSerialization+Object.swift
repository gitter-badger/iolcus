//
//  JSONSerialization+Object.swift
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

extension JSONSerialization {

    static func serialize(properties properties: [Swift.String: JSON], prettyPrint: Bool = false, depth: Int = 0) -> [String.UnicodeScalarView] {
        if properties.count == 0 {
            return [Constant.objectOpeningSequence, Constant.objectClosingSequence]
        }

        let indentBraces = generateIndent(length: depth)
        let indentContent = generateIndent(length: depth + 1)

        let opening = prettyPrint ?
            [Constant.objectOpeningSequence, Constant.newLine, indentContent] :
            [Constant.objectOpeningSequence]

        let separatorKeyValue = prettyPrint ?
            [Constant.objectKeyValueSeparatorSequence, Constant.space] :
            [Constant.objectKeyValueSeparatorSequence]

        let separatorProperty = prettyPrint ?
            [Constant.objectPropertySeparatorSequence, Constant.newLine, indentContent] :
            [Constant.objectPropertySeparatorSequence]

        let closing = prettyPrint ?
            [Constant.newLine, indentBraces, Constant.objectClosingSequence] :
            [Constant.objectClosingSequence]

        let body = properties.map { (key: Swift.String, value: JSON) -> [String.UnicodeScalarView] in
            let serializedKey = serialize(string: key)
            let serializedValue = serialize(json: value, prettyPrint: prettyPrint, depth: depth + 1)

            var result = serializedKey
            result.appendContentsOf(separatorKeyValue)
            result.appendContentsOf(serializedValue)
            return result
        }.joinWithSeparator(separatorProperty)
            
        var result: [String.UnicodeScalarView] = opening
        result.appendContentsOf(body)
        result.appendContentsOf(closing)
        return result
    }
    
}
