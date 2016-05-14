//
//  JSONSerialization+Constant.swift
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

extension JSONSerialization.Constant {
    
    // MARK: - Null
    
    static let nullScalarSequence: String.UnicodeScalarView = "null"

    // MARK: - Boolean

    static let booleanTrueSequence: String.UnicodeScalarView = "true"
    static let booleanFalseSequence: String.UnicodeScalarView = "false"

    // MARK: - String

    static let stringOpeningSequence: String.UnicodeScalarView = "\""
    static let stringClosingSequence: String.UnicodeScalarView = "\""

    static let stringEscapeScalarMap: [UnicodeScalar: String.UnicodeScalarView] =
        [ "\u{00}": "\\u0000", "\u{08}": "\\b",     "\u{10}": "\\u0010", "\u{18}": "\\u0018",
          "\u{01}": "\\u0001", "\u{09}": "\\t",     "\u{11}": "\\u0011", "\u{19}": "\\u0019",
          "\u{02}": "\\u0002", "\u{0a}": "\\n",     "\u{12}": "\\u0012", "\u{1a}": "\\u001a",
          "\u{03}": "\\u0003", "\u{0b}": "\\u000b", "\u{13}": "\\u0013", "\u{1b}": "\\u001b",
          "\u{04}": "\\u0004", "\u{0c}": "\\f",     "\u{14}": "\\u0014", "\u{1c}": "\\u001c",
          "\u{05}": "\\u0005", "\u{0d}": "\\r",     "\u{15}": "\\u0015", "\u{1d}": "\\u001d",
          "\u{06}": "\\u0006", "\u{0e}": "\\u000e", "\u{16}": "\\u0016", "\u{1e}": "\\u001e",
          "\u{07}": "\\u0007", "\u{0f}": "\\u000f", "\u{17}": "\\u0017", "\u{1f}": "\\u001f",
          "\u{22}": "\\\"",
          "\u{2f}": "\\/",
          "\u{5c}": "\\\\" ]

    // MARK: - Array

    static let arrayOpeningSequence: String.UnicodeScalarView = "["
    static let arrayClosingSequence: String.UnicodeScalarView = "]"
    static let arraySeparatorSequence: String.UnicodeScalarView = ", "

    // MARK: - Object

    static let objectOpeningSequence: String.UnicodeScalarView = "{"
    static let objectClosingSequence: String.UnicodeScalarView = "}"
    static let objectKeyValueSeparatorSequence: String.UnicodeScalarView = ": "
    static let objectPropertySeparatorSequence: String.UnicodeScalarView = ", "

}
