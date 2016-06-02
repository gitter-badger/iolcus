//
//  JSONSpec+Unwrapping.swift
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

    func specUnwrapping() {
        describe("unwrapping") {
            let jsonNull: JSON = nil
            let jsonTrue: JSON = true
            let jsonFalse: JSON = false
            let jsonIntZero: JSON = 0
            let jsonIntMax = JSON.Integer(Int.max)
            let jsonIntMin = JSON.Integer(Int.min)
            let jsonFloatZero: JSON = 0.0
            let jsonStringEmpty: JSON = ""
            let jsonStringLorem: JSON = "Lorem"
            let jsonStringWhitespace: JSON = " \n\r \t \n \t \r \t \r\n "
            let jsonArrayWithNothing: JSON = []
            let jsonArrayWithNull: JSON = [JSON.Null]
            let jsonArrayWithBoolean: JSON = [false]
            let jsonArrayWithInteger: JSON = [0]
            let jsonArrayWithFloat: JSON = [0.0]
            let jsonArrayWithString: JSON = ["0"]
            let jsonArrayWithArray: JSON = [JSON.Array([])]
            let jsonArrayWithObject: JSON = [JSON.Object([:])]
            let jsonArrayWithMixup: JSON = [JSON.Null, false, 0, 0.0, "0", JSON.Array([]), JSON.Object([:])]
            let jsonObjectWithNothing: JSON = [:]
            let jsonObjectWithNull: JSON = ["": JSON.Null]
            let jsonObjectWithBoolean: JSON = ["": false]
            let jsonObjectWithInteger: JSON = ["": 0]
            let jsonObjectWithFloat: JSON = ["": 0.0]
            let jsonObjectWithString: JSON = ["": "0"]
            let jsonObjectWithArray: JSON = ["": JSON.Array([])]
            let jsonObjectWithObject: JSON = ["": JSON.Object([:])]
            let jsonObjectWithMixup: JSON = [
                "": JSON.Null, "boolean": false, "integer": 0, "float": 0.0, "string": "0",
                "array": JSON.Array([]), "object": JSON.Object([:])
            ]

            describe("boolean accessor") {
                it("returns correct value for JSON.Boolean") {
                    expect(jsonTrue.unwrappedBoolean) == true
                    expect(jsonFalse.unwrappedBoolean) == false
                }

                it("returns nil for non JSON.Boolean") {
                    expect(jsonNull.unwrappedBoolean).to(beNil())
                    expect(jsonIntZero.unwrappedBoolean).to(beNil())
                    expect(jsonIntMax.unwrappedBoolean).to(beNil())
                    expect(jsonIntMin.unwrappedBoolean).to(beNil())
                    expect(jsonFloatZero.unwrappedBoolean).to(beNil())
                    expect(jsonStringEmpty.unwrappedBoolean).to(beNil())
                    expect(jsonStringLorem.unwrappedBoolean).to(beNil())
                    expect(jsonStringWhitespace.unwrappedBoolean).to(beNil())
                    expect(jsonStringLorem.unwrappedBoolean).to(beNil())
                    expect(jsonStringWhitespace.unwrappedBoolean).to(beNil())
                    expect(jsonArrayWithNothing.unwrappedBoolean).to(beNil())
                    expect(jsonArrayWithNull.unwrappedBoolean).to(beNil())
                    expect(jsonArrayWithBoolean.unwrappedBoolean).to(beNil())
                    expect(jsonArrayWithInteger.unwrappedBoolean).to(beNil())
                    expect(jsonArrayWithFloat.unwrappedBoolean).to(beNil())
                    expect(jsonArrayWithString.unwrappedBoolean).to(beNil())
                    expect(jsonArrayWithArray.unwrappedBoolean).to(beNil())
                    expect(jsonArrayWithObject.unwrappedBoolean).to(beNil())
                    expect(jsonArrayWithString.unwrappedBoolean).to(beNil())
                    expect(jsonArrayWithMixup.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithNothing.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithNull.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithBoolean.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithInteger.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithFloat.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithString.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithArray.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithObject.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithMixup.unwrappedBoolean).to(beNil())
                }
            }

            describe("integer accessor") {
                it("returns correct value for JSON.Integer") {
                    expect(jsonIntZero.unwrappedInteger) == 0
                    expect(jsonIntMax.unwrappedInteger) == Int.max
                    expect(jsonIntMin.unwrappedInteger) == Int.min
                }

                it("returns nil for non JSON.Integer") {
                    expect(jsonNull.unwrappedInteger).to(beNil())
                    expect(jsonTrue.unwrappedInteger).to(beNil())
                    expect(jsonFalse.unwrappedInteger).to(beNil())
                    expect(jsonFloatZero.unwrappedInteger).to(beNil())
                    expect(jsonStringEmpty.unwrappedInteger).to(beNil())
                    expect(jsonStringLorem.unwrappedInteger).to(beNil())
                    expect(jsonStringWhitespace.unwrappedInteger).to(beNil())
                    expect(jsonArrayWithNothing.unwrappedInteger).to(beNil())
                    expect(jsonArrayWithNull.unwrappedInteger).to(beNil())
                    expect(jsonArrayWithBoolean.unwrappedInteger).to(beNil())
                    expect(jsonArrayWithInteger.unwrappedInteger).to(beNil())
                    expect(jsonArrayWithFloat.unwrappedInteger).to(beNil())
                    expect(jsonArrayWithString.unwrappedInteger).to(beNil())
                    expect(jsonArrayWithArray.unwrappedInteger).to(beNil())
                    expect(jsonArrayWithObject.unwrappedInteger).to(beNil())
                    expect(jsonArrayWithString.unwrappedInteger).to(beNil())
                    expect(jsonArrayWithMixup.unwrappedInteger).to(beNil())
                    expect(jsonObjectWithNothing.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithNull.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithBoolean.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithInteger.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithFloat.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithString.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithArray.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithObject.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithMixup.unwrappedBoolean).to(beNil())
                }
            }

            describe("float accessor") {
                it("returns correct value for JSON.Float") {
                    expect(jsonFloatZero.unwrappedFloat) == 0.0
                }

                it("returns nil for non JSON.Float") {
                    expect(jsonNull.unwrappedFloat).to(beNil())
                    expect(jsonTrue.unwrappedFloat).to(beNil())
                    expect(jsonFalse.unwrappedFloat).to(beNil())
                    expect(jsonIntZero.unwrappedFloat).to(beNil())
                    expect(jsonIntMax.unwrappedFloat).to(beNil())
                    expect(jsonIntMin.unwrappedFloat).to(beNil())
                    expect(jsonStringEmpty.unwrappedFloat).to(beNil())
                    expect(jsonStringLorem.unwrappedFloat).to(beNil())
                    expect(jsonStringWhitespace.unwrappedFloat).to(beNil())
                    expect(jsonArrayWithNothing.unwrappedFloat).to(beNil())
                    expect(jsonArrayWithNull.unwrappedFloat).to(beNil())
                    expect(jsonArrayWithBoolean.unwrappedFloat).to(beNil())
                    expect(jsonArrayWithInteger.unwrappedFloat).to(beNil())
                    expect(jsonArrayWithFloat.unwrappedFloat).to(beNil())
                    expect(jsonArrayWithString.unwrappedFloat).to(beNil())
                    expect(jsonArrayWithArray.unwrappedFloat).to(beNil())
                    expect(jsonArrayWithObject.unwrappedFloat).to(beNil())
                    expect(jsonArrayWithString.unwrappedFloat).to(beNil())
                    expect(jsonArrayWithMixup.unwrappedFloat).to(beNil())
                    expect(jsonObjectWithNothing.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithNull.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithBoolean.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithInteger.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithFloat.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithString.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithArray.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithObject.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithMixup.unwrappedBoolean).to(beNil())
                }
            }

            describe("string accessor") {
                it("returns correct value for JSON.String") {
                    expect(jsonStringEmpty.unwrappedString) == ""
                    expect(jsonStringLorem.unwrappedString) == "Lorem"
                    expect(jsonStringWhitespace.unwrappedString) == " \n\r \t \n \t \r \t \r\n "
                }

                it("returns nil for non JSON.String") {
                    expect(jsonNull.unwrappedString).to(beNil())
                    expect(jsonTrue.unwrappedString).to(beNil())
                    expect(jsonFalse.unwrappedString).to(beNil())
                    expect(jsonIntZero.unwrappedString).to(beNil())
                    expect(jsonIntMax.unwrappedString).to(beNil())
                    expect(jsonIntMin.unwrappedString).to(beNil())
                    expect(jsonFloatZero.unwrappedString).to(beNil())
                    expect(jsonArrayWithNothing.unwrappedString).to(beNil())
                    expect(jsonArrayWithNull.unwrappedString).to(beNil())
                    expect(jsonArrayWithBoolean.unwrappedString).to(beNil())
                    expect(jsonArrayWithInteger.unwrappedString).to(beNil())
                    expect(jsonArrayWithFloat.unwrappedString).to(beNil())
                    expect(jsonArrayWithString.unwrappedString).to(beNil())
                    expect(jsonArrayWithArray.unwrappedString).to(beNil())
                    expect(jsonArrayWithObject.unwrappedString).to(beNil())
                    expect(jsonArrayWithString.unwrappedString).to(beNil())
                    expect(jsonArrayWithMixup.unwrappedString).to(beNil())
                    expect(jsonObjectWithNothing.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithNull.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithBoolean.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithInteger.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithFloat.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithString.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithArray.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithObject.unwrappedBoolean).to(beNil())
                    expect(jsonObjectWithMixup.unwrappedBoolean).to(beNil())

                }
            }

            describe("array accessor") {
                it("returns correct value for JSON.Array") {
                    expect(jsonArrayWithNothing.unwrappedArray) == []
                    expect(jsonArrayWithNull.unwrappedArray) == [JSON.Null]
                    expect(jsonArrayWithBoolean.unwrappedArray) == [false]
                    expect(jsonArrayWithInteger.unwrappedArray) == [0]
                    expect(jsonArrayWithFloat.unwrappedArray) == [0.0]
                    expect(jsonArrayWithString.unwrappedArray) == ["0"]
                    expect(jsonArrayWithArray.unwrappedArray) == [JSON.Array([])]
                    expect(jsonArrayWithObject.unwrappedArray) == [JSON.Object([:])]
                    expect(jsonArrayWithMixup.unwrappedArray) == [JSON.Null, false, 0, 0.0, "0", JSON.Array([]), JSON.Object([:])]
                }

                it("returns nil for non JSON.Array") {
                    expect(jsonNull.unwrappedArray).to(beNil())
                    expect(jsonTrue.unwrappedArray).to(beNil())
                    expect(jsonFalse.unwrappedArray).to(beNil())
                    expect(jsonIntZero.unwrappedArray).to(beNil())
                    expect(jsonIntMax.unwrappedArray).to(beNil())
                    expect(jsonIntMin.unwrappedArray).to(beNil())
                    expect(jsonFloatZero.unwrappedArray).to(beNil())
                    expect(jsonStringEmpty.unwrappedArray).to(beNil())
                    expect(jsonStringLorem.unwrappedArray).to(beNil())
                    expect(jsonStringWhitespace.unwrappedArray).to(beNil())
                    expect(jsonObjectWithNothing.unwrappedArray).to(beNil())
                    expect(jsonObjectWithNull.unwrappedArray).to(beNil())
                    expect(jsonObjectWithBoolean.unwrappedArray).to(beNil())
                    expect(jsonObjectWithInteger.unwrappedArray).to(beNil())
                    expect(jsonObjectWithFloat.unwrappedArray).to(beNil())
                    expect(jsonObjectWithString.unwrappedArray).to(beNil())
                    expect(jsonObjectWithArray.unwrappedArray).to(beNil())
                    expect(jsonObjectWithObject.unwrappedArray).to(beNil())
                    expect(jsonObjectWithMixup.unwrappedArray).to(beNil())

                }
            }

            describe("object accessor") {
                it("returns correct value for JSON.Object") {
                    expect(jsonObjectWithNothing.unwrappedObject) == [:]
                    expect(jsonObjectWithNull.unwrappedObject) == ["": JSON.Null]
                    expect(jsonObjectWithBoolean.unwrappedObject) == ["": false]
                    expect(jsonObjectWithInteger.unwrappedObject) == ["": 0]
                    expect(jsonObjectWithFloat.unwrappedObject) == ["": 0.0]
                    expect(jsonObjectWithString.unwrappedObject) == ["": "0"]
                    expect(jsonObjectWithArray.unwrappedObject) == ["": JSON.Array([])]
                    expect(jsonObjectWithObject.unwrappedObject) == ["": JSON.Object([:])]
                    expect(jsonObjectWithMixup.unwrappedObject) == [
                        "": JSON.Null, "boolean": false, "integer": 0, "float": 0.0, "string": "0",
                        "array": JSON.Array([]), "object": JSON.Object([:])
                    ]
                }

                it("returns nil for non JSON.Object") {
                    expect(jsonNull.unwrappedObject).to(beNil())
                    expect(jsonTrue.unwrappedObject).to(beNil())
                    expect(jsonFalse.unwrappedObject).to(beNil())
                    expect(jsonIntZero.unwrappedObject).to(beNil())
                    expect(jsonIntMax.unwrappedObject).to(beNil())
                    expect(jsonIntMin.unwrappedObject).to(beNil())
                    expect(jsonFloatZero.unwrappedObject).to(beNil())
                    expect(jsonStringEmpty.unwrappedObject).to(beNil())
                    expect(jsonStringLorem.unwrappedObject).to(beNil())
                    expect(jsonStringWhitespace.unwrappedObject).to(beNil())
                    expect(jsonArrayWithNothing.unwrappedObject).to(beNil())
                    expect(jsonArrayWithNull.unwrappedObject).to(beNil())
                    expect(jsonArrayWithBoolean.unwrappedObject).to(beNil())
                    expect(jsonArrayWithInteger.unwrappedObject).to(beNil())
                    expect(jsonArrayWithFloat.unwrappedObject).to(beNil())
                    expect(jsonArrayWithString.unwrappedObject).to(beNil())
                    expect(jsonArrayWithArray.unwrappedObject).to(beNil())
                    expect(jsonArrayWithObject.unwrappedObject).to(beNil())
                    expect(jsonArrayWithString.unwrappedObject).to(beNil())
                    expect(jsonArrayWithMixup.unwrappedObject).to(beNil())
                }
            }
        }
    }

}
