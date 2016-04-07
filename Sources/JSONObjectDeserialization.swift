//
//  JSONObjectDeserialization.swift
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

final class JSONObjectDeserialization: JSONDeserialization {
    
    override func deserialize() throws -> JSON? {
        resetPeekedCharacters()
        skipWhitespaceCharacters()
        
        do {
            guard let opening = readCharacter() else {
                throw JSON.Exception.Serializing.UnexpectedEOF
            }
            
            if opening != JSONConstants.objectOpening {
                throw JSON.Exception.Serializing.UnexpectedCharacter(character: opening, position: scannerPosition)
            }
        }
        
        var properties: [String: JSON] = [:]
        
        readLoop: while true {
            skipWhitespaceCharacters()
            
            guard let ending = peekCharacter() else {
                throw JSON.Exception.Serializing.UnexpectedEOF
            }
            
            if ending == JSONConstants.objectClosing {
                break readLoop
            }
            
            guard let key = try deserializeString()?.stringValue else {
                throw JSON.Exception.Serializing.FailedToReadKey(position: scannerPosition)
            }
            
            if properties.keys.contains(key) {
                throw JSON.Exception.Serializing.DuplicateObjectKey(key: key, position: scannerPosition)
            }
            
            skipWhitespaceCharacters()
            
            do {
                guard let keyValueSeparator = readCharacter() else {
                    throw JSON.Exception.Serializing.UnexpectedEOF
                }
                
                if keyValueSeparator != JSONConstants.objectKeyValueSeparator {
                    throw JSON.Exception.Serializing.UnexpectedCharacter(character: keyValueSeparator, position: scannerPosition)
                }
            }
            
            guard let value = try deserializeValue() else {
                throw JSON.Exception.Serializing.FailedToReadValue(position: scannerPosition)
            }
            
            properties[key] = value
            
            skipWhitespaceCharacters()
            
            guard let separator = peekCharacter() else {
                throw JSON.Exception.Serializing.UnexpectedEOF
            }
            
            if separator != JSONConstants.objectPropertySeparator {
                break readLoop
            }
            
            skipPeekedCharacters()
        }
        
        do {
            guard let ending = readCharacter() else {
                throw JSON.Exception.Serializing.UnexpectedEOF
            }
            
            if ending != JSONConstants.objectClosing {
                throw JSON.Exception.Serializing.UnexpectedCharacter(character: ending, position: scannerPosition)
            }
        }
        
        return JSON.Object(properties)
    }
    
}
