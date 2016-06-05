//
//  JSONDeserialization+Constant.swift
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

extension JSONDeserialization {
    
    struct Constant {

        // MARK: - Whitespace
        
        static let whitespaceScalars: Set<UnicodeScalar> = [ " ", "\t", "\r", "\n" ]
        
        // MARK: - Null
        
        static let nullOpeningScalar: UnicodeScalar = "n"
        static let nullScalarSequence: String.UnicodeScalarView = "null"
        
        // MARK: - Boolean
        
        static let booleanTrueOpeningScalar: UnicodeScalar = "t"
        static let booleanTrueSequence: String.UnicodeScalarView = "true"
        
        static let booleanFalseOpeningScalar: UnicodeScalar = "f"
        static let booleanFalseSequence: String.UnicodeScalarView = "false"
        
        // MARK: - Number
        
        static let numberOpeningScalars: Set<UnicodeScalar> =
            [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-" ]
        
        static let numberScalars: Set<UnicodeScalar> =
            [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "+", ".", "e", "E" ]
        
        // MARK: - String
        
        static let stringOpeningScalar: UnicodeScalar = "\""
        static let stringClosingScalar: UnicodeScalar = "\""
        static let stringUnescapeScalar: UnicodeScalar = "\\"
        static let stringUnescapeUnicodeScalar: UnicodeScalar = "u"
        
        static let stringUnescapeScalarMap: [UnicodeScalar: UnicodeScalar] =
            [ "\"": "\u{22}", "n": "\u{0a}", "t": "\u{09}", "b": "\u{08}",
              "\\": "\u{5c}", "r": "\u{0d}", "f": "\u{0c}", "/": "\u{2f}" ]
        
        static let stringForbiddenScalars: Set<UnicodeScalar> =
            [ "\u{00}", "\u{01}", "\u{02}", "\u{03}", "\u{04}", "\u{05}", "\u{06}", "\u{07}",
              "\u{08}", "\u{09}", "\u{0a}", "\u{0b}", "\u{0c}", "\u{0d}", "\u{0e}", "\u{0f}",
              "\u{10}", "\u{11}", "\u{12}", "\u{13}", "\u{14}", "\u{15}", "\u{16}", "\u{17}",
              "\u{18}", "\u{19}", "\u{1a}", "\u{1b}", "\u{1c}", "\u{1d}", "\u{1e}", "\u{1f}" ]
        
        // MARK: - Array
        
        static let arrayOpeningScalar: UnicodeScalar = "["
        static let arrayClosingScalar: UnicodeScalar = "]"
        static let arraySeparatorScalar: UnicodeScalar = ","
        
        // MARK: - Object
        
        static let objectOpeningScalar: UnicodeScalar = "{"
        static let objectClosingScalar: UnicodeScalar = "}"
        static let objectKeyValueSeparatorScalar: UnicodeScalar = ":"
        static let objectPropertySeparatorScalar: UnicodeScalar = ","
        
    }
    
}
