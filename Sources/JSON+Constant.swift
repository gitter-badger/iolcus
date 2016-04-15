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

    static let whitespace : Set<UnicodeScalar> = [ " ", "\t", "\r", "\n" ]
    
    // MARK: - Null

    static let nullSequence  : [UnicodeScalar] = [ "n", "u", "l", "l" ]
    
    // MARK: - Boolean

    static let trueSequence  : [UnicodeScalar] = [ "t", "r", "u", "e" ]
    static let falseSequence : [UnicodeScalar] = [ "f", "a", "l", "s", "e" ]

    // MARK: - Number

    static let numberOpenings   : Set<UnicodeScalar> =
        [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-" ]
    
    static let numberRepresentationElements : Set<UnicodeScalar> =
        [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "+", ".", "e", "E" ]
    
    // MARK: - String
    
    static let stringOpening       : UnicodeScalar = "\""
    static let stringClosing       : UnicodeScalar = "\""
    static let stringEscape        : UnicodeScalar = "\\"
    static let stringEscapeUnicode : UnicodeScalar = "u"
    
    static let stringUnescapeMap   : [UnicodeScalar: UnicodeScalar] =
        [ "\"" : "\u{22}",  "n" : "\u{0a}",  "t" : "\u{09}",  "b" : "\u{08}",
          "\\" : "\u{5c}",  "r" : "\u{0d}",  "f" : "\u{0c}",  "/" : "\u{2f}" ]
    
    static let stringForbidden     : Set<UnicodeScalar> =
        [ "\u{00}", "\u{01}", "\u{02}", "\u{03}", "\u{04}", "\u{05}", "\u{06}", "\u{07}",
          "\u{08}", "\u{09}", "\u{0a}", "\u{0b}", "\u{0c}", "\u{0d}", "\u{0e}", "\u{0f}",
          "\u{10}", "\u{11}", "\u{12}", "\u{13}", "\u{14}", "\u{15}", "\u{16}", "\u{17}",
          "\u{18}", "\u{19}", "\u{1a}", "\u{1b}", "\u{1c}", "\u{1d}", "\u{1e}", "\u{1f}" ]

    static let stringEscapeMap     : [UnicodeScalar: String.UnicodeScalarView] =
        [ "\u{00}" : "u0000",    "\u{08}" : "b",        "\u{10}" : "u0010",    "\u{18}" : "u0018",
          "\u{01}" : "u0001",    "\u{09}" : "t",        "\u{11}" : "u0011",    "\u{19}" : "u0019",
          "\u{02}" : "u0002",    "\u{0a}" : "n",        "\u{12}" : "u0012",    "\u{1a}" : "u001a",
          "\u{03}" : "u0003",    "\u{0b}" : "u000b",    "\u{13}" : "u0013",    "\u{1b}" : "u001b",
          "\u{04}" : "u0004",    "\u{0c}" : "f",        "\u{14}" : "u0014",    "\u{1c}" : "u001c",
          "\u{05}" : "u0005",    "\u{0d}" : "r",        "\u{15}" : "u0015",    "\u{1d}" : "u001d",
          "\u{06}" : "u0006",    "\u{0e}" : "u000e",    "\u{16}" : "u0016",    "\u{1e}" : "u001e",
          "\u{07}" : "u0007",    "\u{0f}" : "u000f",    "\u{17}" : "u0017",    "\u{1f}" : "u001f",
          "\u{22}" : "\"",
          "\u{2f}" : "/",
          "\u{5c}" : "\\" ]
    

    // MARK: - Array
    
    static let arrayOpening   : UnicodeScalar = "["
    static let arrayClosing   : UnicodeScalar = "]"
    static let arraySeparator : UnicodeScalar = ","
    
    // MARK: - Object

    static let objectOpening           : UnicodeScalar = "{"
    static let objectClosing           : UnicodeScalar = "}"
    static let objectKeyValueSeparator : UnicodeScalar = ":"
    static let objectPropertySeparator : UnicodeScalar = ","
    
}
