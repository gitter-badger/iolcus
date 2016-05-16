//
//  JSONSpec.swift
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

import Nimble
import Quick
import Medea

class JSONSpec: QuickSpec {

    override func spec() {
        describe("literal initializer") {
            it("initializes boolean literal as JSON.Boolean") {
                let json: JSON = true
                expect(json) == JSON.Boolean(true)
            }

            it("initializes integer literal as JSON.Integer") {
                let json: JSON = 123456789
                expect(json) == JSON.Integer(123456789)
            }

            it("initializes double liteal as JSON.Double") {
                let json: JSON = 123456.789
                expect(json) == JSON.Double(123456.789)
            }

            it("initializes double liteal as JSON.String") {
                let json: JSON = "Lorem ipsum"
                expect(json) == JSON.String("Lorem ipsum")
            }
        }
    }
    
}
