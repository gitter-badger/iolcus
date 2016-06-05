//
//  JSONSerialization+String.swift
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

extension JSONSerialization {

    static func serialize(string string: String) -> [String.UnicodeScalarView] {
        var result: [String.UnicodeScalarView] = [Constant.stringOpeningSequence]
        
        let scalars = string.unicodeScalars
        var intervalStart = scalars.startIndex
        for index in scalars.startIndex..<scalars.endIndex {
            if let substitute = Constant.stringEscapeScalarMap[scalars[index]] {
                if intervalStart < index {
                    let interval = intervalStart..<index
                    result.append(scalars[interval])
                }
                result.append(substitute)
                intervalStart = index.advancedBy(1)
            }
        }
        if intervalStart < scalars.endIndex {
            let interval = intervalStart..<scalars.endIndex
            result.append(scalars[interval])
        }
        
        result.append(Constant.stringClosingSequence)
        
        return result
    }
    
}
