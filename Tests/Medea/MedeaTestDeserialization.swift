//
//  MedeaTestDeserialization.swift
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

import XCTest

@testable import Medea

class MedeaTestDeserialization: XCTestCase {
    
    let whitespace: [String] = [ "", " ", "\t", "\n", "\r" ]
    
    let validRepresentations: [JSON: String] = [
        .Null                           : "null",
        .Boolean(true)                  : "true",
        .Boolean(false)                 : "false",
        .Integer(0)                     : "0",
        .Integer(Int.min)               : "\(Int.min)",
        .Integer(Int.max)               : "\(Int.max)",
        .Double(0.0)                    : "0.0",
        .Double(-12345.6789)            : "-12345.6789",
        .Double(12345.6789)             : "12345.6789",
        .Array([false, 1, 2.0, "3"])    : "[false, 1, 2.0, \"3\"]",
        .Object([
            "name": "John Do",
            "age": 42,
            "weight": 66.6,
            "married": true,
            "children": ["Sid", "Mary"]
        ])                              :"{\"name\":\"John Do\", \"age\": 42, \"weight\":66.6, \"married\": true, \"children\": [\"Sid\", \"Mary\"]}"
    ]
    
    func verifyThat(representation representation: String, deserializesInto expectation: JSON) {
        do {
            let json = try JSONDeserialization.makeJSON(withString: representation)
            XCTAssertEqual(json, expectation, "String \"\(representation)\" should deserialize into \(expectation)")
        }
        catch {
            XCTFail("Deserialization of \"\(representation)\" failed with error \(error)")
        }
    }
    
    func produce(combinationsOf elements: [String], withDepth depth: Int) -> [String] {
        assert(depth >= 0)
        
        if depth == 0 {
            return elements
        }
        
        return elements.flatMap() { (element: String) in
            self.produce(combinationsOf: elements, withDepth: depth - 1).map() {
                $0 + element
            }
        }
    }
    
    func testThatJSONDeserializesCorrectly() {
        validRepresentations.forEach() { (let json: JSON, let representation: String) in
            self.verifyThat(
                representation: representation,
                deserializesInto: json
            )
            
        }
        
    }

}
