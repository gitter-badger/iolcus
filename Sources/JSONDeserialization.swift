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

struct JSONDeserialization {
    
    var scanner: Scanner<Character>
    var scannerPosition: Int { return scanner.position }
    
    init(_ scanner: Scanner<Character>) {
        self.scanner = scanner
    }
    
    // MARK: - Scanning trough the input
    
    mutating func readCharacter() throws -> Character {
        guard let readCharacter = scanner.next() else {
            throw JSON.Exception.Deserializing.UnexpectedEOF
        }
        
        return readCharacter
    }
    
    mutating func readExpectedCharacter(expectedCharacter: Character) throws {
        let character = try readCharacter()
        
        if character != expectedCharacter {
            throw JSON.Exception.Deserializing.UnexpectedCharacter(character: character, position: scanner.position)
        }
    }
    
    mutating func peekCharacter() throws -> Character {
        guard let peekedCharacter = scanner.peek() else {
            throw JSON.Exception.Deserializing.UnexpectedEOF
        }
        
        return peekedCharacter
    }
    
    mutating func peekExpectedCharacter(expectedCharacter: Character) throws {
        let character = try peekCharacter()
        
        if character != expectedCharacter {
            throw JSON.Exception.Deserializing.UnexpectedCharacter(character: character, position: scanner.position)
        }
    }
    
    mutating func resetPeekedCharacters() {
        scanner.resetPeek()
    }
    
    mutating func skipPeekedCharacters() {
        scanner.skipPeeked()
    }
    
    mutating func skipWhitespaceCharacters() {
        scanner.skipWhile(JSON.Constant.whitespace.contains)
    }

}
