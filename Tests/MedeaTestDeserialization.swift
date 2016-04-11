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
    
    static let jsonString01 = try! String(
        contentsOfFile: NSBundle(forClass: MedeaTestDeserialization.self).pathForResource("json01", ofType: "json")!,
        encoding: NSUTF8StringEncoding
    )

    static let jsonString02 = try! String(
        contentsOfFile: NSBundle(forClass: MedeaTestDeserialization.self).pathForResource("json02", ofType: "json")!,
        encoding: NSUTF8StringEncoding
    )
    
    static let jsonString03 = try! String(
        contentsOfFile: NSBundle(forClass: MedeaTestDeserialization.self).pathForResource("json03", ofType: "json")!,
        encoding: NSUTF8StringEncoding
    )

    func testDeserializationFromString() {
        do {
            let json: JSON = try JSONDeserialization.jsonWithString(MedeaTestDeserialization.jsonString01)
        } catch {
            XCTFail("Error while deserializing JSON: \(error)")
        }
    }
    
}
