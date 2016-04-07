//
//  JSONStringSerialization.swift
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

struct JSONStringSerialization: GeneratorType {
    
    private enum State {
        case Open, Reading, Closed
    }
    
    private let nextUnescapedCharacter: Void -> Character?
    private var buffer: [Character] = []
    private var state = State.Open
    
    init(_ string: String) {
        var generator = string.characters.generate()
        
        nextUnescapedCharacter = {
            return generator.next()
        }
    }
    
    mutating func next() -> Character? {
        switch state {
        case .Open:
            state = .Reading
            return JSONConstants.stringOpening
        case .Reading:
            if let character = nextEscapedCharacter() {
                return character
            }
            state = .Closed
            return JSONConstants.stringClosing
        case .Closed:
            return nil
        }
    }
    
    private mutating func nextEscapedCharacter() -> Character? {
        if let character = buffer.first {
            buffer.removeFirst()
            return character
        }
        
        if let character = nextUnescapedCharacter() {
            if let escapeSequence = JSONConstants.stringEscapeMap[character] {
                buffer.appendContentsOf(escapeSequence.characters)
                return JSONConstants.stringEscape
            }

            return character
        }

        return nil
    }

}
