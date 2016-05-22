//
//  JSONSpec+Initializing.swift
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

extension JSONSpec {

    func specLiteralInitializers() {
        describe("literal initializer") {
            it("initializes nil literal into JSON.Null") {
                let json: JSON = nil
                expect(json) == JSON.Null
            }

            it("initializes boolean literal into JSON.Boolean") {
                let json: JSON = true
                expect(json) == JSON.Boolean(true)
            }

            it("initializes integer literal into JSON.Integer") {
                let json: JSON = 123456789
                expect(json) == JSON.Integer(123456789)
            }

            it("initializes float liteal into JSON.Float") {
                let json: JSON = 123456.789
                expect(json) == JSON.Float(123456.789)
            }

            it("initializes string liteal into JSON.String") {
                let json: JSON = "Lorem ipsum"
                expect(json) == JSON.String("Lorem ipsum")
            }

            it("initializes array literal into JSON.Array") {
                let json: JSON = [true, 2, 3.0, "IV"]
                expect(json) == JSON.Array(
                    [
                        JSON.Boolean(true),
                        JSON.Integer(2),
                        JSON.Float(3.0),
                        JSON.String("IV")
                    ]
                )
            }

            it("initializes dictionary literal into JSON.Object") {
                let json: JSON = ["boolean": true, "integer": 2, "float": 3.0, "string": "IV"]
                expect(json) == JSON.Object(
                    [
                        "boolean": JSON.Boolean(true),
                        "integer": JSON.Integer(2),
                        "float": JSON.Float(3.0),
                        "string": JSON.String("IV")
                    ]
                )
            }
        }
    }

    func specEncodableInitializers() {
        describe("encodable initializer") {
            it("initializes instance of JSONEncodable into the same value as its jsonEncoded() method returns") {
                let encodable = "Lorem ipsum"
                let json = JSON(encodable: encodable)
                expect(json) == encodable.jsonEncoded()
            }

            it("initializes array of JSONEncodable into JSON.Array of jsonEncodable() results") {
                let encodableArray1: [String] = ["Lorem", "ipsum", "dolor", "sit", "amet"]
                let encodableArray2: [JSONEncodable] = ["Lorem", "ipsu", "dolor", "sit", "amet"]

                let json1 = JSON(encodable: encodableArray1)
                let json2 = JSON(encodable: encodableArray2)

                expect(json1) == JSON.Array(encodableArray1.map({$0.jsonEncoded()}))
                expect(json2) == JSON.Array(encodableArray2.map({$0.jsonEncoded()}))
            }

            it("initializes dictionary [String: JSONEncodable] into JSON.Object with jsonEncodable() results") {
                let encodableDictionary1: [String: String] = ["1": "Lorem", "2": "ipsum", "3": "dolor", "4": "sit", "5": "amet"]
                let encodableDictionary2: [String: JSONEncodable] = ["1": "Lorem", "2": "ipsum", "3": "dolor", "4": "sit", "5": "amet"]

                let json1 = JSON(encodable: encodableDictionary1)
                let json2 = JSON(encodable: encodableDictionary2)

                expect(json1) == JSON.Object(
                    [
                        "1": encodableDictionary1["1"]?.jsonEncoded() ?? JSON.Null,
                        "2": encodableDictionary1["2"]?.jsonEncoded() ?? JSON.Null,
                        "3": encodableDictionary1["3"]?.jsonEncoded() ?? JSON.Null,
                        "4": encodableDictionary1["4"]?.jsonEncoded() ?? JSON.Null,
                        "5": encodableDictionary1["5"]?.jsonEncoded() ?? JSON.Null,
                    ]
                )
                expect(json2) == JSON.Object(
                    [
                        "1": encodableDictionary1["1"]?.jsonEncoded() ?? JSON.Null,
                        "2": encodableDictionary1["2"]?.jsonEncoded() ?? JSON.Null,
                        "3": encodableDictionary1["3"]?.jsonEncoded() ?? JSON.Null,
                        "4": encodableDictionary1["4"]?.jsonEncoded() ?? JSON.Null,
                        "5": encodableDictionary1["5"]?.jsonEncoded() ?? JSON.Null,
                    ]
                )
            }
        }
    }

}
