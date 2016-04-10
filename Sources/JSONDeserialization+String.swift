//
//  JSONDeserialization.swift
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

extension JSONDeserialization {

    mutating func deserializeString() throws -> JSON {
        let string = try readString()
        return JSON.String(string)
    }

    mutating func readString() throws -> String {
        try readExpectedCharacter(JSON.Constant.stringOpening)
        
        var string = ""
        
        readLoop: while true {
            let character = try peekCharacter()
            
            if character == JSON.Constant.stringClosing {
                break readLoop
            }
            
            if character == JSON.Constant.stringEscape {
                let escapedCharacter = try readEscapedCharacter()
                string.append(escapedCharacter)
            }
            
            if JSON.Constant.stringForbidden.contains(character) {
                skipPeekedCharacters()
                throw JSON.Error.Deserializing.UnexpectedCharacter(character: character, position: position)
            }
            
            skipPeekedCharacters()
            
            string.append(character)
        }
        
        try readExpectedCharacter(JSON.Constant.stringClosing)
        
        return string
    }

    private mutating func readEscapedCharacter() throws -> Character {
        resetPeekedCharacters()
        
        try peekExpectedCharacter(JSON.Constant.stringEscape)
        let escapeClassifier = try peekCharacter()
        
        if let escapedCharacter = JSON.Constant.stringUnescapeMap[escapeClassifier] {
            skipPeekedCharacters()
            return escapedCharacter
        }
        
        if escapeClassifier == JSON.Constant.stringEscapeUnicode {
            return try readEscapedUnicodeCharacter()
        }
        
        skipPeekedCharacters()
        throw JSON.Error.Deserializing.UnexpectedCharacter(character: escapeClassifier, position: position)
    }
    
    private mutating func readEscapedUnicodeCharacter() throws -> Character {
        try readExpectedCharacter(JSON.Constant.stringEscape)
        try readExpectedCharacter(JSON.Constant.stringEscapeUnicode)
        
        let codepoint = try readCodepoint()
        
        if !isSurrogate(codepoint) {
            return Character(UnicodeScalar(codepoint))
        }
        
        // If the first codepoint was surrogate then we must read the second surrogate too
        
        let highSurrogateCodepoint = codepoint
        
        try readExpectedCharacter(JSON.Constant.stringEscape)
        try readExpectedCharacter(JSON.Constant.stringEscapeUnicode)
        
        let lowSurrogateCodepoint = try readCodepoint()
        
        // See 3.7 at http://unicode.org/versions/Unicode3.0.0/ch03.pdf
        
        let compositeCodepoint = (highSurrogateCodepoint - 0xD800) * 0x400 + lowSurrogateCodepoint - 0xDC00 + 0x10000
        
        return Character(UnicodeScalar(compositeCodepoint))
    }
    
    private mutating func readCodepoint() throws -> Int {
        var hexCharacters: [Character] = []
        
        for _ in 0..<4 {
            let hexCharacter = try readCharacter()
            hexCharacters.append(hexCharacter)
        }
        
        let hex = String(hexCharacters)
        
        guard let codepoint = Int(hex, radix: 16) else {
            throw JSON.Error.Deserializing.FailedToReadHex(hex: hex, position: position)
        }
        
        return codepoint
    }
    
    private func isSurrogate(codepoint: Int) -> Bool {
        return codepoint >= 0xd800
            && codepoint < 0xe000
    }

}