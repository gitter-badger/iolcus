//
//  JSONSpec+Equatable.swift
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

    func specEquatable() {
        describe("equatable implementation") {
            it("matches JSON.Null values") {
                let json1: JSON = nil
                let json2: JSON = nil
                expect(json1) == json2
            }

            it("only matches JSON.Boolean values that have equal wrapped booleans") {
                do {
                    let json1: JSON = false
                    let json2: JSON = false
                    expect(json1) == json2
                }

                do {
                    let json1: JSON = true
                    let json2: JSON = true
                    expect(json1) == json2
                }
            }

            it("only matches JSON.Integer values that have equal wrapped values") {
                let elements1: [JSON] = [-3, -2, -1, 0, 1, 2, 3]
                let elements2: [JSON] = [-3, -2, -1, 0, 1, 2, 3]

                elements1.enumerate().forEach { (index1: Int, element1: JSON) in
                    elements2.enumerate().forEach { (index2: Int, element2: JSON) in
                        if index1 == index2 {
                            expect(element1) == element2
                        } else {
                            expect(element1) != element2
                        }
                    }
                }
            }

            it("only matches JSON.Float values that have equal wrapped values") {
                let elements1: [JSON] = [-3.0, -2.0, -1.0, 0.0, 1.0, 2.0, 3.0]
                let elements2: [JSON] = [-3.0, -2.0, -1.0, 0.0, 1.0, 2.0, 3.0]

                elements1.enumerate().forEach { (index1: Int, element1: JSON) in
                    elements2.enumerate().forEach { (index2: Int, element2: JSON) in
                        if index1 == index2 {
                            expect(element1) == element2
                        } else {
                            expect(element1) != element2
                        }
                    }
                }
            }

            it("only matches JSON.Float values that have equal wrapped strings") {
                let elements1: [JSON] = ["Lorem", "ipsum", "dolor", "sit", "amet"]
                let elements2: [JSON] = ["Lorem", "ipsum", "dolor", "sit", "amet"]

                elements1.enumerate().forEach { (index1: Int, element1: JSON) in
                    elements2.enumerate().forEach { (index2: Int, element2: JSON) in
                        if index1 == index2 {
                            expect(element1) == element2
                        } else {
                            expect(element1) != element2
                        }
                    }
                }
            }

            it("only matches exact same kinds of JSON") {
                let null1: JSON = nil
                let null2: JSON = nil
                let false1: JSON = false
                let false2: JSON = false
                let intZero1: JSON = 0
                let intZero2: JSON = 0
                let floatZero1: JSON = 0.0
                let floatZero2: JSON = 0.0
                let stringZero1: JSON = "0"
                let stringZero2: JSON = "0"
                let tinyArray1: JSON = [false]
                let tinyArray2: JSON = [false]
                let smallArray1: JSON = [false, 0]
                let smallArray2: JSON = [false, 0]
                let mediumArray1: JSON = [false, 0, 0.0]
                let mediumArray2: JSON = [false, 0, 0.0]
                let bigArray1: JSON = [false, 0, 0.0, "0"]
                let bigArray2: JSON = [false, 0, 0.0, "0"]
                let tinyDictionary1: JSON = ["1": false]
                let tinyDictionary2: JSON = ["1": false]
                let smallDictionary1: JSON = ["1": false, "2": 0]
                let smallDictionary2: JSON = ["1": false, "2": 0]
                let mediumDictionary1: JSON = ["1": false, "2": 0, "3": 0.0]
                let mediumDictionary2: JSON = ["1": false, "2": 0, "3": 0.0]
                let bigDictionary1: JSON = ["1": false, "2": 0, "3": 0.0, "4": "0"]
                let bigDictionary2: JSON = ["1": false, "2": 0, "3": 0.0, "4": "0"]

                let elements1: [JSON] = [null1, false1, intZero1, floatZero1, stringZero1, tinyArray1,
                                         smallArray1, mediumArray1, bigArray1, tinyDictionary1,
                                         smallDictionary1, mediumDictionary1, bigDictionary1]
                let elements2: [JSON] = [null2, false2, intZero2, floatZero2, stringZero2, tinyArray2,
                                         smallArray2, mediumArray2, bigArray2, tinyDictionary2,
                                         smallDictionary2, mediumDictionary2, bigDictionary2]

                elements1.enumerate().forEach { (index1: Int, element1: JSON) in
                    elements2.enumerate().forEach { (index2: Int, element2: JSON) in
                        if index1 == index2 {
                            expect(element1) == element2
                        } else {
                            expect(element1) != element2
                        }
                    }
                }
            }
        }
    }

}
