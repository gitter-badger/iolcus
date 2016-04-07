//
//  JSON+Constants.swift
//  Medea
//
//  Created by Anton Bronnikov on 24/03/2016.
//  Copyright © 2016 northernforest. All rights reserved.
//

extension JSON.Constants {
    
    static let whitespace : Set<Character> = [ " ", "\t", "\r", "\n" ]
    
    static let nullSequence  : [Character] = [ "n", "u", "l", "l" ]
    
    static let trueSequence  : [Character] = [ "t", "r", "u", "e" ]
    static let falseSequence : [Character] = [ "f", "a", "l", "s", "e" ]

    static let numberOpenings   : Set<Character> = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-" ]
    static let numberCharacters : Set<Character> = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", "+", ".", "e", "E" ]
    
    static let objectOpening           : Character = "{"
    static let objectClosing           : Character = "}"
    static let objectKeyValueSeparator : Character = ":"
    static let objectPropertySeparator : Character = ","
    
    static let arrayOpening   : Character = "["
    static let arrayClosing   : Character = "]"
    static let arraySeparator : Character = ","
    
    static let stringOpening       : Character = "\""
    static let stringClosing       : Character = "\""
    static let stringEscape        : Character = "\\"
    static let stringEscapeUnicode : Character = "u"
    
    static let stringUnescapeMap : [Character: Character] = [ "\"" : "\u{22}",  "n" : "\u{0a}",  "t" : "\u{09}",  "b" : "\u{08}",
                                                              "\\" : "\u{5c}",  "r" : "\u{0d}",  "f" : "\u{0c}",  "/" : "\u{2f}" ]

    static let stringEscapeMap : [Character: String] = [ "\u{00}" : "u0000",    "\u{08}" : "b",        "\u{10}" : "u0010",    "\u{18}" : "u0018",
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
    
    static let stringForbidden : Set<Character> = [ "\u{00}", "\u{01}", "\u{02}", "\u{03}", "\u{04}", "\u{05}", "\u{06}", "\u{07}",
                                                    "\u{08}", "\u{09}", "\u{0a}", "\u{0b}", "\u{0c}", "\u{0d}", "\u{0e}", "\u{0f}",
                                                    "\u{10}", "\u{11}", "\u{12}", "\u{13}", "\u{14}", "\u{15}", "\u{16}", "\u{17}",
                                                    "\u{18}", "\u{19}", "\u{1a}", "\u{1b}", "\u{1c}", "\u{1d}", "\u{1e}", "\u{1f}" ]
    
}
