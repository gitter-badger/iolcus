//
//  JSONSpec+EncodableInitializers.swift
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

import Nimble
import Quick
import Iolcus

extension JSONSpec {

    func specEncodableInitializers() {
        describe("encodable initializer") {
            it("initializes instance of JSONEncodable into the same value as its jsonEncoded() method returns") {
                let encodable = "Lorem ipsum"
                let json = JSON(encoding: encodable)
                expect(json) == encodable.jsonEncoded()
            }

            it("initializes array [JSONEncodable] into JSON.Array with jsonEncodable() results") {
                let encodableArray1: [String] = ["Lorem", "ipsum", "dolor", "sit", "amet"]
                let encodableArray2: [JSONEncodable] = ["Lorem", "ipsu", "dolor", "sit", "amet"]

                let json1 = JSON(encoding: encodableArray1)
                let json2 = JSON(encoding: encodableArray2)

                expect(json1) == JSON.Array(encodableArray1.map { $0.jsonEncoded() })
                expect(json2) == JSON.Array(encodableArray2.map { $0.jsonEncoded() })
            }

            it("initializes dictionary [String: JSONEncodable] into JSON.Object with jsonEncodable() results") {
                let encodableDictionary1: [String: String] = ["1": "Lorem", "2": "ipsum", "3": "dolor", "4": "sit", "5": "amet"]
                let encodableDictionary2: [String: JSONEncodable] = ["1": "Lorem", "2": "ipsum", "3": "dolor", "4": "sit", "5": "amet"]

                let json1 = JSON(encoding: encodableDictionary1)
                let json2 = JSON(encoding: encodableDictionary2)

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

            it("initializes dictionary [StringConvertible: [JSONEncodable]] into JSON.Object([String: JSON.Array]) with jsonEncodable() results") {
                let subArray11: [JSONEncodable] = ["Lorem"]
                let subArray12: [JSONEncodable] = ["ipsum", "dolor"]
                let subArray13: [JSONEncodable] = ["sit", "consectetur", "adipiscing", "elit"]

                let subArray21: [String] = ["Lorem"]
                let subArray22: [String] = ["ipsum", "dolor"]
                let subArray23: [String] = ["sit", "consectetur", "adipiscing", "elit"]

                let encodableDictionary1: [String: [JSONEncodable]] = ["1": subArray11, "2": subArray12, "3": subArray13]
                let encodableDictionary2: [String: [String]] = ["1": subArray21, "2": subArray22, "3": subArray23]

                let json1 = JSON(encoding: encodableDictionary1)
                let json2 = JSON(encoding: encodableDictionary2)

                let expectation = JSON.Object(
                    [
                        "1": ["Lorem"],
                        "2": ["ipsum", "dolor"],
                        "3": ["sit", "consectetur", "adipiscing", "elit"]
                    ]
                )

                expect(json1) == expectation
                expect(json2) == expectation
            }
        }
    }

}
