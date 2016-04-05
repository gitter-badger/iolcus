//
//  JSONSerialization.swift
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

public class JSONSerialization {
    
    private let scanner: Scanner<Character>
    var scannerPosition: Int { return scanner.position }
    
    init(_ scanner: Scanner<Character>) {
        self.scanner = scanner
    }
    
    // MARK: - Scanning trough the input
    
    final func readCharacter() -> Character? {
        let readCharacter = scanner.next()
        return readCharacter
    }
    
    final func peekCharacter() -> Character? {
        let peekedCharacter = scanner.peek()
        return peekedCharacter
    }
    
    final func resetPeekedCharacters() {
        scanner.resetPeek()
    }
    
    final func skipPeekedCharacters() {
        scanner.skipPeeked()
    }
    
    final func skipWhitespaceCharacters() {
        scanner.skipWhile(JSONConstants.whitespace.contains)
    }

    // MARK: - Internal serialization
    
    func serialize() throws -> JSON? {
        fatalError("Must override")
    }
    
    final func serializeNull() throws -> JSON? {
        return try JSONNullSerialization(scanner).serialize()
    }
    
    final func serializeBool() throws -> JSON? {
        return try JSONBoolSerialization(scanner).serialize()
    }
    
    final func serializeNumber() throws -> JSON? {
        return try JSONNumberSerialization(scanner).serialize()
    }
    
    final func serializeString() throws -> JSON? {
        return try JSONStringSerialization(scanner).serialize()
    }
    
    final func serializeArray() throws -> JSON? {
        return try JSONArraySerialization(scanner).serialize()
    }
    
    final func serializeObject() throws -> JSON? {
        return try JSONObjectSerialization(scanner).serialize()
    }
    
    final func serializeValue() throws -> JSON? {
        return try JSONValueSerialization(scanner).serialize()
    }
    
}

// MARK: - Exposed API

extension JSONSerialization {
    
    public static func jsonWithString(string: Swift.String) throws -> JSON? {
        let scanner = Scanner(string.characters)
        return try serializeFromScanner(scanner)
    }
    
    public static func jsonWithSequence<S: SequenceType where S.Generator.Element == Character>(sequence: S) throws -> JSON? {
        let scanner = Scanner(sequence)
        return try serializeFromScanner(scanner)
    }
    
    public static func jsonWithGenerator<G: GeneratorType where G.Element == Character>(generator: G) throws -> JSON? {
        let scanner = Scanner(generator)
        return try serializeFromScanner(scanner)
    }
    
    public static func jsonWithClosure(closure: Void -> Character?) throws -> JSON? {
        let scanner = Scanner(closure)
        return try serializeFromScanner(scanner)
    }
    
    private static func serializeFromScanner(scanner: Scanner<Character>) throws -> JSON? {
        let serialization = JSONValueSerialization(scanner)
        let json = try serialization.serialize()
        
        serialization.skipWhitespaceCharacters()
        
        if let tail = serialization.readCharacter() {
            throw JSON.Exception.Serializing.UnexpectedCharacter(character: tail, position: serialization.scannerPosition)
        }
        
        return json
    }
    
}

// MARK: - Foundation version of JSON

#if os(OSX) || os(iOS) || os(tvOS)
    
extension JSONSerialization {
    
    public static func jsonWithNSJSON(nsjson: AnyObject) throws -> JSON {
        if let json = nsjson as? [NSString: AnyObject] {
            return try jsonWithNSJSON(json)
        }
        
        if let json = nsjson as? [AnyObject] {
            return try jsonWithNSJSON(json)
        }
        
        if let json = nsjson as? NSString {
            return try jsonWithNSJSON(json)
        }
        
        if let json = nsjson as? NSNumber {
            return try jsonWithNSJSON(json)
        }
        
        if let json = nsjson as? NSNull {
            return try jsonWithNSJSON(json)
        }
        
        throw JSON.Exception.Serializing.FailedToReadNSJSON(type: nsjson.dynamicType)
    }
    
    private static func jsonWithNSJSON(nsjson: NSNull) throws -> JSON {
        return .Null
    }
    
    private static func jsonWithNSJSON(nsjson: NSNumber) throws -> JSON {
        let double = nsjson.doubleValue
        return .Double(double)
    }
    
    private static func jsonWithNSJSON(nsjson: NSString) throws -> JSON {
        let string = nsjson as Swift.String
        return .String(string)
    }
    
    private static func jsonWithNSJSON(nsjson: [AnyObject]) throws -> JSON {
        let array = try nsjson.map() {
            try jsonWithNSJSON($0)
        }
        return .Array(array)
    }
    
    private static func jsonWithNSJSON(nsjson: [NSString: AnyObject]) throws -> JSON {
        var properties: [Swift.String: JSON] = [:]
        try nsjson.forEach() {
            let key = $0 as Swift.String
            let value = try jsonWithNSJSON($1)
            properties[key] = value
        }
        return .Object(properties)
    }

}
    
#endif
