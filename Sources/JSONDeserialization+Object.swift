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

    mutating func deserializeObject() throws -> JSON {
        let object = try readObject()
        return JSON.Object(object)
    }

    private mutating func readObject() throws -> [String: JSON] {
        try readExpectedCharacter(JSON.Constant.objectOpening)
        
        var object: [String: JSON] = [:]
        
        readLoop: while true {
            skipWhitespaceCharacters()
            
            if try peekCharacter() == JSON.Constant.objectClosing {
                break readLoop
            }
            
            let key = try readString()
            
            if object.keys.contains(key) {
                throw JSON.Error.Deserializing.DuplicateObjectKey(key: key, position: position)
            }
            
            skipWhitespaceCharacters()
            
            try readExpectedCharacter(JSON.Constant.objectKeyValueSeparator)

            skipWhitespaceCharacters()

            object[key] = try deserializeValue()
            
            skipWhitespaceCharacters()
            
            if try peekCharacter() != JSON.Constant.objectPropertySeparator {
                break readLoop
            }
            
            skipPeekedCharacters()
        }
        
        try readExpectedCharacter(JSON.Constant.objectClosing)

        return object
    }
    
}
