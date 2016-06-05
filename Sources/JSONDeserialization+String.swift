//
//  JSONDeserialization+String.swift
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

    mutating func deserializeString() throws -> JSON {
        let string = try readString()
        return JSON.String(string)
    }

    mutating func readString() throws -> String {
        try readExpectedScalar(Constant.stringOpeningScalar)
        
        var scalars = String.UnicodeScalarView()
        
        readLoop: while true {
            let scalar = try readScalar()
            
            if scalar == Constant.stringClosingScalar {
                break readLoop
            }
            
            if scalar == Constant.stringUnescapeScalar {
                let escapedSymbol = try readEscapedSymbol()
                scalars.append(escapedSymbol)
            } else if Constant.stringForbiddenScalars.contains(scalar) {
                throw JSON.Error.Deserializing.UnexpectedScalar(scalar: scalar, position: position)
            } else {
                scalars.append(scalar)
            }
        }
        
        return String(scalars)
    }

    private mutating func readEscapedSymbol() throws -> UnicodeScalar {
        let scalar = try readScalar()
        
        if let escapedScalar = Constant.stringUnescapeScalarMap[scalar] {
            return escapedScalar
        }
        
        if scalar == Constant.stringUnescapeUnicodeScalar {
            return try readEscapedUnicodeCharacter()
        }
        
        throw JSON.Error.Deserializing.UnexpectedScalar(scalar: scalar, position: position)
    }
    
    private mutating func readEscapedUnicodeCharacter() throws -> UnicodeScalar {
        let codepoint = try readCodepoint()
        
        if !isSurrogate(codepoint) {
            return UnicodeScalar(codepoint)
        }
        
        // If the first codepoint was surrogate then we must read the second surrogate as well
        
        try readExpectedScalar(Constant.stringUnescapeScalar)
        try readExpectedScalar(Constant.stringUnescapeUnicodeScalar)
        
        let lowCodepoint = try readCodepoint()
        
        // See 3.7 at http://unicode.org/versions/Unicode3.0.0/ch03.pdf
        
        let fullCodepoint = (codepoint - 0xD800) * 0x400 + lowCodepoint - 0xDC00 + 0x10000
        
        return UnicodeScalar(fullCodepoint)
    }
    
    private mutating func readCodepoint() throws -> Int {
        var scalars = String.UnicodeScalarView()
        scalars.reserveCapacity(4)
        
        for _ in 0..<4 {
            let scalar = try readScalar()
            scalars.append(scalar)
        }
        
        let string = String(scalars)
        
        guard let codepoint = Int(string, radix: 16) else {
            throw JSON.Error.Deserializing.FailureInterpretingHex(hex: string, position: position)
        }
        
        return codepoint
    }
    
    private func isSurrogate(codepoint: Int) -> Bool {
        return codepoint >= 0xd800
            && codepoint < 0xe000
    }

}
