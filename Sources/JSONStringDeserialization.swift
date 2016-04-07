//
//  JSONStringDeserialization.swift
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

final class JSONStringDeserialization: JSONDeserialization {
    
    override func deserialize() throws -> JSON? {
        resetPeekedCharacters()
        skipWhitespaceCharacters()
        
        do {
            guard let opening = readCharacter() else {
                throw JSON.Exception.Serializing.UnexpectedEOF
            }
            
            if opening != JSON.Constants.stringOpening {
                throw JSON.Exception.Serializing.UnexpectedCharacter(character: opening, position: scannerPosition)
            }
        }
        
        var string = ""
        
        readLoop: while true {
            guard let character = peekCharacter() else {
                throw JSON.Exception.Serializing.UnexpectedEOF
            }
            
            switch character {
            case JSON.Constants.stringClosing:
                break readLoop
            case JSON.Constants.stringEscape:
                let escapedCharacter = try readEscapedCharacter()
                string.append(escapedCharacter)
            case JSON.Constants.stringForbidden:
                throw JSON.Exception.Serializing.UnexpectedCharacter(character: character, position: scannerPosition)
            default:
                string.append(character)
            }
            
            skipPeekedCharacters()
        }
        
        do {
            guard let ending = readCharacter() else {
                throw JSON.Exception.Serializing.UnexpectedEOF
            }
            
            if ending != JSON.Constants.stringClosing {
                throw JSON.Exception.Serializing.UnexpectedCharacter(character: ending, position: scannerPosition)
            }
        }
        
        return JSON.String(string)
    }
    
    // MARK: - Helpers
    
    private func readEscapedCharacter() throws -> Character {
        defer { skipPeekedCharacters() }
        
        resetPeekedCharacters()
        
        do {
            guard let escapeCharacter = peekCharacter() else {
                throw JSON.Exception.Serializing.UnexpectedEOF
            }
            
            if escapeCharacter != JSON.Constants.stringEscape {
                throw JSON.Exception.Serializing.UnexpectedCharacter(character: escapeCharacter, position: scannerPosition)
            }
        }
        
        guard let escapeClassifier = peekCharacter() else {
            throw JSON.Exception.Serializing.UnexpectedEOF
        }
        
        if let mapping = JSON.Constants.stringUnescapeMap[escapeClassifier] {
            return mapping
        }

        if escapeClassifier == JSON.Constants.stringEscapeUnicode {
            return try readEscapedUnicodeCharacter()
        }
        
        throw JSON.Exception.Serializing.UnexpectedCharacter(character: escapeClassifier, position: scannerPosition)
    }
    
    private func readEscapedUnicodeCharacter() throws -> Character {
        do {
            guard let escapeCharacter = readCharacter() else {
                throw JSON.Exception.Serializing.UnexpectedEOF
            }
            
            if escapeCharacter != JSON.Constants.stringEscape {
                throw JSON.Exception.Serializing.UnexpectedCharacter(character: escapeCharacter, position: scannerPosition)
            }
            
            guard let escapeClassifier = readCharacter() else {
                throw JSON.Exception.Serializing.UnexpectedEOF
            }
            
            if escapeClassifier != JSON.Constants.stringEscapeUnicode {
                throw JSON.Exception.Serializing.UnexpectedCharacter(character: escapeClassifier, position: scannerPosition)
            }
        }
        
        let codepoint = try readCodepoint()
        
        if !isSurrogate(codepoint) {
            return Character(UnicodeScalar(codepoint))
        }
        
        // If the first codepoint was surrogate then we must read the second surrogate too
        
        let highSurrogateCodepoint = codepoint
        
        do {
            guard let escapeCharacter = readCharacter() else {
                throw JSON.Exception.Serializing.UnexpectedEOF
            }
            
            if escapeCharacter != JSON.Constants.stringEscape {
                throw JSON.Exception.Serializing.UnexpectedCharacter(character: escapeCharacter, position: scannerPosition)
            }
            
            guard let escapeClassifier = readCharacter() else {
                throw JSON.Exception.Serializing.UnexpectedEOF
            }
            
            if escapeClassifier != JSON.Constants.stringEscapeUnicode {
                throw JSON.Exception.Serializing.UnexpectedCharacter(character: escapeClassifier, position: scannerPosition)
            }
        }
        
        let lowSurrogateCodepoint = try readCodepoint()
        
        // See 3.7 at http://unicode.org/versions/Unicode3.0.0/ch03.pdf
        
        let compositeCodepoint = (highSurrogateCodepoint - 0xD800) * 0x400 + lowSurrogateCodepoint - 0xDC00 + 0x10000
        
        return Character(UnicodeScalar(compositeCodepoint))
    }
    
    private func readCodepoint() throws -> Int {
        var hexCharacters: [Character] = []
        
        for _ in 0..<4 {
            guard let hexCharacter = readCharacter() else {
                throw JSON.Exception.Serializing.UnexpectedEOF
            }
            hexCharacters.append(hexCharacter)
        }
        
        let hex = String(hexCharacters)
        
        guard let codepoint = Int(hex, radix: 16) else {
            throw JSON.Exception.Serializing.FailedToReadHex(hex: hex, position: scannerPosition)
        }
        
        return codepoint
    }
    
    private func isSurrogate(codepoint: Int) -> Bool {
        return codepoint >= 0xd800
            && codepoint < 0xe000
    }
    
}
