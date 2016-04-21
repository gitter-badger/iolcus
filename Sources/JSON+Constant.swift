//
//  JSON+Constants.swift
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

extension JSON.Constant {
    
    private init() { }
    
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
    static let stringOpeningSequence: String.UnicodeScalarView = "\""

    static let stringClosingScalar: UnicodeScalar = "\""
    static let stringClosingSequence: String.UnicodeScalarView = "\""

    static let stringUnescapeScalar: UnicodeScalar = "\\"
    static let stringUnescapeUnicodeScalar: UnicodeScalar = "u"
    static let stringUnescapeScalarMap: [UnicodeScalar: UnicodeScalar] =
        [ "\"" : "\u{22}",  "n" : "\u{0a}",  "t" : "\u{09}",  "b" : "\u{08}",
          "\\" : "\u{5c}",  "r" : "\u{0d}",  "f" : "\u{0c}",  "/" : "\u{2f}" ]
    
    static let stringEscapeScalarMap: [UnicodeScalar: String.UnicodeScalarView] =
        [ "\u{00}" : "\\u0000",  "\u{08}" : "\\b",      "\u{10}" : "\\u0010",  "\u{18}" : "\\u0018",
          "\u{01}" : "\\u0001",  "\u{09}" : "\\t",      "\u{11}" : "\\u0011",  "\u{19}" : "\\u0019",
          "\u{02}" : "\\u0002",  "\u{0a}" : "\\n",      "\u{12}" : "\\u0012",  "\u{1a}" : "\\u001a",
          "\u{03}" : "\\u0003",  "\u{0b}" : "\\u000b",  "\u{13}" : "\\u0013",  "\u{1b}" : "\\u001b",
          "\u{04}" : "\\u0004",  "\u{0c}" : "\\f",      "\u{14}" : "\\u0014",  "\u{1c}" : "\\u001c",
          "\u{05}" : "\\u0005",  "\u{0d}" : "\\r",      "\u{15}" : "\\u0015",  "\u{1d}" : "\\u001d",
          "\u{06}" : "\\u0006",  "\u{0e}" : "\\u000e",  "\u{16}" : "\\u0016",  "\u{1e}" : "\\u001e",
          "\u{07}" : "\\u0007",  "\u{0f}" : "\\u000f",  "\u{17}" : "\\u0017",  "\u{1f}" : "\\u001f",
          "\u{22}" : "\\\"",
          "\u{2f}" : "\\/",
          "\u{5c}" : "\\\\" ]

    static let stringForbiddenScalars: Set<UnicodeScalar> =
        [ "\u{00}", "\u{01}", "\u{02}", "\u{03}", "\u{04}", "\u{05}", "\u{06}", "\u{07}",
          "\u{08}", "\u{09}", "\u{0a}", "\u{0b}", "\u{0c}", "\u{0d}", "\u{0e}", "\u{0f}",
          "\u{10}", "\u{11}", "\u{12}", "\u{13}", "\u{14}", "\u{15}", "\u{16}", "\u{17}",
          "\u{18}", "\u{19}", "\u{1a}", "\u{1b}", "\u{1c}", "\u{1d}", "\u{1e}", "\u{1f}" ]

//    static let stringEscapeMap     : [UnicodeScalar: [UnicodeScalar]] =
//        [ "\u{00}" : [ "u", "0", "0", "0", "0" ],    "\u{10}" : [ "u", "0", "0", "1", "0" ],
//          "\u{01}" : [ "u", "0", "0", "0", "1" ],    "\u{11}" : [ "u", "0", "0", "1", "1" ],
//          "\u{02}" : [ "u", "0", "0", "0", "2" ],    "\u{12}" : [ "u", "0", "0", "1", "2" ],
//          "\u{03}" : [ "u", "0", "0", "0", "3" ],    "\u{13}" : [ "u", "0", "0", "1", "3" ],
//          "\u{04}" : [ "u", "0", "0", "0", "4" ],    "\u{14}" : [ "u", "0", "0", "1", "4" ],
//          "\u{05}" : [ "u", "0", "0", "0", "5" ],    "\u{15}" : [ "u", "0", "0", "1", "5" ],
//          "\u{06}" : [ "u", "0", "0", "0", "6" ],    "\u{16}" : [ "u", "0", "0", "1", "6" ],
//          "\u{07}" : [ "u", "0", "0", "0", "7" ],    "\u{17}" : [ "u", "0", "0", "1", "7" ],
//          "\u{08}" : [ "b"                     ],    "\u{18}" : [ "u", "0", "0", "1", "8" ],
//          "\u{09}" : [ "t"                     ],    "\u{19}" : [ "u", "0", "0", "1", "9" ],
//          "\u{0a}" : [ "n"                     ],    "\u{1a}" : [ "u", "0", "0", "1", "a" ],
//          "\u{0b}" : [ "u", "0", "0", "0", "b" ],    "\u{1b}" : [ "u", "0", "0", "1", "b" ],
//          "\u{0c}" : [ "f"                     ],    "\u{1c}" : [ "u", "0", "0", "1", "c" ],
//          "\u{0d}" : [ "r"                     ],    "\u{1d}" : [ "u", "0", "0", "1", "d" ],
//          "\u{0e}" : [ "u", "0", "0", "0", "e" ],    "\u{1e}" : [ "u", "0", "0", "1", "e" ],
//          "\u{0f}" : [ "u", "0", "0", "0", "f" ],    "\u{1f}" : [ "u", "0", "0", "1", "f" ],
//          "\u{22}" : [ "\""                    ],
//          "\u{2f}" : [ "/"                     ],
//          "\u{5c}" : [ "\\"                    ] ]

    // MARK: - Array
    
    static let arrayOpeningScalar: UnicodeScalar = "["
    static let arrayOpeningSequence: String.UnicodeScalarView = "[ "
    
    static let arrayClosingScalar: UnicodeScalar = "]"
    static let arrayClosingSequence: String.UnicodeScalarView = " ]"
    
    static let arraySeparatorScalar: UnicodeScalar = ","
    static let arraySeparatorSequence: String.UnicodeScalarView = ", "
    
    // MARK: - Object

    static let objectOpeningScalar: UnicodeScalar = "{"
    static let objectOpeningSequence: String.UnicodeScalarView = "{ "
    
    static let objectClosingScalar: UnicodeScalar = "}"
    static let objectClosingSequence: String.UnicodeScalarView = " }"
    
    static let objectKeyValueSeparatorScalar: UnicodeScalar = ":"
    static let objectKeyValueSeparatorSequence: String.UnicodeScalarView = ": "
    
    static let objectPropertySeparatorScalar: UnicodeScalar = ","
    static let objectPropertySeparatorSequence: String.UnicodeScalarView = ", "
    
}
