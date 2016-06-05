//
//  JSONSpec+Inspection.swift
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

    func specInspection() {
        describe("inspection") {
            let jsonNull: JSON = nil
            let jsonBoolean: JSON = false
            let josnInteger: JSON = 0
            let jsonFloat: JSON = 0.0
            let jsonString: JSON = ""
            let jsonArray: JSON = []
            let jsonObject: JSON = [:]

            describe("via kind") {
                it("returns string identifying type of JSON") {
                    expect(jsonNull.kind) == "Null"
                    expect(jsonBoolean.kind) == "Boolean"
                    expect(josnInteger.kind) == "Integer"
                    expect(jsonFloat.kind) == "Float"
                    expect(jsonString.kind) == "String"
                    expect(jsonArray.kind) == "Array"
                    expect(jsonObject.kind) == "Object"
                }
            }

            describe("via isNull") {
                it("only returns true if self is JSON.Null") {
                    expect(jsonNull.isNull).to(beTrue())
                    expect(jsonBoolean.isNull).to(beFalse())
                    expect(josnInteger.isNull).to(beFalse())
                    expect(jsonFloat.isNull).to(beFalse())
                    expect(jsonString.isNull).to(beFalse())
                    expect(jsonArray.isNull).to(beFalse())
                    expect(jsonObject.isNull).to(beFalse())
                }
            }

            describe("via isBoolean") {
                it("only returns true if self is JSON.Boolean") {
                    expect(jsonNull.isBoolean).to(beFalse())
                    expect(jsonBoolean.isBoolean).to(beTrue())
                    expect(josnInteger.isBoolean).to(beFalse())
                    expect(jsonFloat.isBoolean).to(beFalse())
                    expect(jsonString.isBoolean).to(beFalse())
                    expect(jsonArray.isBoolean).to(beFalse())
                    expect(jsonObject.isBoolean).to(beFalse())
                }
            }

            describe("via isInteger") {
                it("only returns true if self is JSON.Integer") {
                    expect(jsonNull.isInteger).to(beFalse())
                    expect(jsonBoolean.isInteger).to(beFalse())
                    expect(josnInteger.isInteger).to(beTrue())
                    expect(jsonFloat.isInteger).to(beFalse())
                    expect(jsonString.isInteger).to(beFalse())
                    expect(jsonArray.isInteger).to(beFalse())
                    expect(jsonObject.isInteger).to(beFalse())
                }
            }

            describe("via isFloat") {
                it("only returns true if self is JSON.Float") {
                    expect(jsonNull.isFloat).to(beFalse())
                    expect(jsonBoolean.isFloat).to(beFalse())
                    expect(josnInteger.isFloat).to(beFalse())
                    expect(jsonFloat.isFloat).to(beTrue())
                    expect(jsonString.isFloat).to(beFalse())
                    expect(jsonArray.isFloat).to(beFalse())
                    expect(jsonObject.isFloat).to(beFalse())
                }
            }

            describe("via isNumber") {
                it("only returns true if self is JSON.Integer or JSON.Float") {
                    expect(jsonNull.isNumber).to(beFalse())
                    expect(jsonBoolean.isNumber).to(beFalse())
                    expect(josnInteger.isNumber).to(beTrue())
                    expect(jsonFloat.isNumber).to(beTrue())
                    expect(jsonString.isNumber).to(beFalse())
                    expect(jsonArray.isNumber).to(beFalse())
                    expect(jsonObject.isNumber).to(beFalse())
                }
            }

            describe("via isString") {
                it("only returns true if self is JSON.String") {
                    expect(jsonNull.isString).to(beFalse())
                    expect(jsonBoolean.isString).to(beFalse())
                    expect(josnInteger.isString).to(beFalse())
                    expect(jsonFloat.isString).to(beFalse())
                    expect(jsonString.isString).to(beTrue())
                    expect(jsonArray.isString).to(beFalse())
                    expect(jsonObject.isString).to(beFalse())
                }
            }

            describe("via isArray") {
                it("only returns true if self is JSON.Array") {
                    expect(jsonNull.isArray).to(beFalse())
                    expect(jsonBoolean.isArray).to(beFalse())
                    expect(josnInteger.isArray).to(beFalse())
                    expect(jsonFloat.isArray).to(beFalse())
                    expect(jsonString.isArray).to(beFalse())
                    expect(jsonArray.isArray).to(beTrue())
                    expect(jsonObject.isArray).to(beFalse())
                }
            }

            describe("via isObject") {
                it("only returns true if self is JSON.Object") {
                    expect(jsonNull.isObject).to(beFalse())
                    expect(jsonBoolean.isObject).to(beFalse())
                    expect(josnInteger.isObject).to(beFalse())
                    expect(jsonFloat.isObject).to(beFalse())
                    expect(jsonString.isObject).to(beFalse())
                    expect(jsonArray.isObject).to(beFalse())
                    expect(jsonObject.isObject).to(beTrue())
                }
            }
        }
    }

}
