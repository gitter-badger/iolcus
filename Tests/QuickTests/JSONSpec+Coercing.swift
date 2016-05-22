//
//  JSONSpec+Coercing.swift
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

    func specCoercing() {
        describe("coercing") {
            let jsonNull: JSON = nil

            let jsonTrue: JSON = true
            let jsonFalse: JSON = false

            let jsonIntZero: JSON = 0
            let jsonIntOne: JSON = 1
            let jsonIntPlusMillion: JSON = 1_000_000
            let jsonIntMinusMillion: JSON = -1_000_000

            let jsonFloatZero: JSON = 0.0
            let jsonFloatOne: JSON = 1.0
            let jsonFloatPlusOneAndHalf: JSON = 1.5
            let jsonFloatMinusOneAndHalf: JSON = -1.5
            let jsonFloatPlusMillion: JSON = 1_000_000.0
            let jsonFloatMinusMillion: JSON = -1_000_000.0
            let jsonFloatPlusMillionAndQuarter: JSON = 1_000_000.25
            let jsonFloatMinusMillionAndQuarter: JSON = -1_000_000.25
            let jsonFloatPlusTenPowerHundred: JSON = 1e+100
            let josnFloatMinutTenPowerHundred: JSON = -1e+100

            let jsonStringEmpty: JSON = ""
            let jsonStringLorem: JSON = "Lorem"
            let jsonStringWhitespace: JSON = " \n\r \t \n \t \r \t \r\n "
            let jsonStringTrue: JSON = "true"
            let jsonStringFalse: JSON = "false"
            let jsonStringZero: JSON = "0"
            let jsonStringPlusMillion: JSON = "1000000"
            let jsonStringMinusMillion: JSON = "-1000000"
            let jsonStringPlusOneAndHalf: JSON = "1.5"
            let jsonStringMinusOneAndHalf: JSON = "-1.5"
            let jsonStringPlusTenPowerThirty: JSON = "1000000000000000000000000000000"
            let josnStringMinutTenPowerThirty: JSON = "-1000000000000000000000000000000"
            let jsonStringPlusTenPowerHundred: JSON = "1e100"
            let josnStringMinutTenPowerHundred: JSON = "-1e100"

            let jsonArrayWithNothing: JSON = []
            let jsonArrayWithTrue: JSON = [true]
            let jsonArrayWithFalse: JSON = [false]
            let jsonArrayWithIntegerZero: JSON = [0]
            let jsonArrayWithIntegerOne: JSON = [1]
            let jsonArrayWithFloatZero: JSON = [0.0]
            let jsonArrayWithFloatOne: JSON = [1.0]
            let jsonArrayWithStringZero: JSON = ["0"]
            let jsonArrayWithStringOne: JSON = ["1"]
            let jsonArrayWithStringTrue: JSON = ["true"]
            let jsonArrayWithStringFalse: JSON = ["false"]

            let jsonObjectWithNothing: JSON = [:]
            let jsonObjectWithTrue: JSON = ["": true]
            let jsonObjectWithFalse: JSON = ["": false]
            let jsonObjectWithIntegerZero: JSON = ["": 0]
            let jsonObjectWithIntegerOne: JSON = ["": 1]
            let jsonObjectWithFloatZero: JSON = ["": 0.0]
            let jsonObjectWithFloatOne: JSON = ["": 1.0]
            let jsonObjectWithStringZero: JSON = ["": "0"]
            let jsonObjectWithStringOne: JSON = ["": "1"]
            let jsonObjectWithStringFalse: JSON = ["": "false"]
            let jsonObjectWithStringTrue: JSON = ["": "true"]

            // MARK: coercedBoolean

            describe("boolean") {
                describe("from JSON.Null") {
                    it("returns nil") {
                        expect(jsonNull.coercedBoolean).to(beNil())
                    }
                }

                describe("from JSON.Boolean") {
                    it("returns the wrapped value") {
                        expect(jsonTrue.coercedBoolean) == true
                        expect(jsonFalse.coercedBoolean) == false
                    }
                }

                describe("from JSON.Integer") {
                    it("returns false for zero") {
                        expect(jsonIntZero.coercedBoolean) == false
                    }

                    it("returns true for non-zero") {
                        expect(jsonIntOne.coercedBoolean) == true
                        expect(jsonIntPlusMillion.coercedBoolean) == true
                        expect(jsonIntMinusMillion.coercedBoolean) == true
                    }
                }

                describe("from JSON.Float") {
                    it("returns false for zero") {
                        expect(jsonFloatZero.coercedBoolean) == false
                    }

                    it("returns true for non-zero and for infinity") {
                        expect(jsonFloatOne.coercedBoolean) == true

                        expect(jsonFloatMinusOneAndHalf.coercedBoolean) == true
                        expect(jsonFloatPlusOneAndHalf.coercedBoolean) == true
                        expect(jsonFloatPlusMillion.coercedBoolean) == true
                        expect(jsonFloatMinusMillion.coercedBoolean) == true
                        expect(jsonFloatPlusMillionAndQuarter.coercedBoolean) == true
                        expect(jsonFloatMinusMillionAndQuarter.coercedBoolean) == true
                        expect(jsonFloatPlusTenPowerHundred.coercedBoolean) == true
                        expect(josnFloatMinutTenPowerHundred.coercedBoolean) == true
                    }
                }

                describe("from JSON.String") {
                    it("returns true for true") {
                        expect(jsonStringTrue.coercedBoolean) == true
                    }

                    it("returns false for false") {
                        expect(jsonStringFalse.coercedBoolean) == false
                    }

                    it("returns nil for not true or false") {
                        expect(jsonStringEmpty.coercedBoolean).to(beNil())
                        expect(jsonStringLorem.coercedBoolean).to(beNil())
                        expect(jsonStringWhitespace.coercedBoolean).to(beNil())
                        expect(jsonStringZero.coercedBoolean).to(beNil())
                        expect(jsonStringPlusMillion.coercedBoolean).to(beNil())
                        expect(jsonStringMinusMillion.coercedBoolean).to(beNil())
                        expect(jsonStringPlusOneAndHalf.coercedBoolean).to(beNil())
                        expect(jsonStringMinusOneAndHalf.coercedBoolean).to(beNil())
                        expect(jsonStringPlusTenPowerThirty.coercedBoolean).to(beNil())
                        expect(josnStringMinutTenPowerThirty.coercedBoolean).to(beNil())
                        expect(jsonStringPlusTenPowerHundred.coercedBoolean).to(beNil())
                        expect(josnStringMinutTenPowerHundred.coercedBoolean).to(beNil())
                    }
                }

                describe("from JSON.Array") {
                    it("returns nil") {
                        expect(jsonArrayWithNothing.coercedBoolean).to(beNil())
                        expect(jsonArrayWithTrue.coercedBoolean).to(beNil())
                        expect(jsonArrayWithFalse.coercedBoolean).to(beNil())
                        expect(jsonArrayWithIntegerZero.coercedBoolean).to(beNil())
                        expect(jsonArrayWithIntegerOne.coercedBoolean).to(beNil())
                        expect(jsonArrayWithFloatZero.coercedBoolean).to(beNil())
                        expect(jsonArrayWithFloatOne.coercedBoolean).to(beNil())
                        expect(jsonArrayWithStringZero.coercedBoolean).to(beNil())
                        expect(jsonArrayWithStringOne.coercedBoolean).to(beNil())
                        expect(jsonArrayWithStringTrue.coercedBoolean).to(beNil())
                        expect(jsonArrayWithStringFalse.coercedBoolean).to(beNil())
                    }
                }

                describe("from JSON.Object") {
                    it("returns nil") {
                        expect(jsonObjectWithNothing.coercedBoolean).to(beNil())
                        expect(jsonObjectWithTrue.coercedBoolean).to(beNil())
                        expect(jsonObjectWithFalse.coercedBoolean).to(beNil())
                        expect(jsonObjectWithIntegerZero.coercedBoolean).to(beNil())
                        expect(jsonObjectWithIntegerOne.coercedBoolean).to(beNil())
                        expect(jsonObjectWithFloatZero.coercedBoolean).to(beNil())
                        expect(jsonObjectWithFloatOne.coercedBoolean).to(beNil())
                        expect(jsonObjectWithStringZero.coercedBoolean).to(beNil())
                        expect(jsonObjectWithStringOne.coercedBoolean).to(beNil())
                        expect(jsonObjectWithStringFalse.coercedBoolean).to(beNil())
                        expect(jsonObjectWithStringTrue.coercedBoolean).to(beNil())
                    }
                }
            }

            // MARK: coercedInteger

            describe("integer") {
                describe("from JSON.Null") {
                    it("returns nil") {
                        expect(jsonNull.coercedInteger).to(beNil())
                    }
                }

                describe("from JSON.Boolean") {
                    it("returns 1 for true") {
                        expect(jsonTrue.coercedInteger) == 1
                    }

                    it("returns 0 for false") {
                        expect(jsonFalse.coercedInteger) == 0
                    }
                }

                describe("from JSON.Integer") {
                    it("returns the wrapped value") {
                        expect(jsonIntZero.coercedInteger) == 0
                        expect(jsonIntOne.coercedInteger) == 1
                        expect(jsonIntPlusMillion.coercedInteger) == 1_000_000
                        expect(jsonIntMinusMillion.coercedInteger) == -1_000_000
                    }
                }

                describe("from JSON.Float") {
                    it("returns truncated integer part for in-range numbers") {
                        expect(jsonFloatZero.coercedInteger) == 0
                        expect(jsonFloatOne.coercedInteger) == 1
                        expect(jsonFloatMinusOneAndHalf.coercedInteger) == -1
                        expect(jsonFloatPlusOneAndHalf.coercedInteger) == 1
                        expect(jsonFloatPlusMillion.coercedInteger) == 1_000_000
                        expect(jsonFloatMinusMillion.coercedInteger) == -1_000_000
                        expect(jsonFloatPlusMillionAndQuarter.coercedInteger) == 1_000_000
                        expect(jsonFloatMinusMillionAndQuarter.coercedInteger) == -1_000_000
                    }

                    it("returns nil value for out-of-range numbers") {
                        expect(jsonFloatPlusTenPowerHundred.coercedInteger).to(beNil())
                        expect(josnFloatMinutTenPowerHundred.coercedInteger).to(beNil())
                    }
                }

                describe("from JSON.String") {
                    it("converts into integer where possible") {
                        expect(jsonStringZero.coercedInteger) == 0
                        expect(jsonStringPlusMillion.coercedInteger) == 1_000_000
                        expect(jsonStringMinusMillion.coercedInteger) == -1_000_000
                    }

                    it("returns nil when conversion into integer is not possible") {
                        expect(jsonStringEmpty.coercedInteger).to(beNil())
                        expect(jsonStringLorem.coercedInteger).to(beNil())
                        expect(jsonStringWhitespace.coercedInteger).to(beNil())
                        expect(jsonStringTrue.coercedInteger).to(beNil())
                        expect(jsonStringFalse.coercedInteger).to(beNil())
                        expect(jsonStringPlusOneAndHalf.coercedInteger).to(beNil())
                        expect(jsonStringMinusOneAndHalf.coercedInteger).to(beNil())
                        expect(jsonStringPlusTenPowerThirty.coercedInteger).to(beNil())
                        expect(josnStringMinutTenPowerThirty.coercedInteger).to(beNil())
                        expect(jsonStringPlusTenPowerHundred.coercedInteger).to(beNil())
                        expect(josnStringMinutTenPowerHundred.coercedInteger).to(beNil())
                    }
                }

                describe("from JSON.Array") {
                    it("returns nil") {
                        expect(jsonArrayWithNothing.coercedInteger).to(beNil())
                        expect(jsonArrayWithTrue.coercedInteger).to(beNil())
                        expect(jsonArrayWithFalse.coercedInteger).to(beNil())
                        expect(jsonArrayWithIntegerZero.coercedInteger).to(beNil())
                        expect(jsonArrayWithIntegerOne.coercedInteger).to(beNil())
                        expect(jsonArrayWithFloatZero.coercedInteger).to(beNil())
                        expect(jsonArrayWithFloatOne.coercedInteger).to(beNil())
                        expect(jsonArrayWithStringZero.coercedInteger).to(beNil())
                        expect(jsonArrayWithStringOne.coercedInteger).to(beNil())
                        expect(jsonArrayWithStringTrue.coercedInteger).to(beNil())
                        expect(jsonArrayWithStringFalse.coercedInteger).to(beNil())
                    }
                }

                describe("from JSON.Object") {
                    it("returns nil") {
                        expect(jsonObjectWithNothing.coercedInteger).to(beNil())
                        expect(jsonObjectWithTrue.coercedInteger).to(beNil())
                        expect(jsonObjectWithFalse.coercedInteger).to(beNil())
                        expect(jsonObjectWithIntegerZero.coercedInteger).to(beNil())
                        expect(jsonObjectWithIntegerOne.coercedInteger).to(beNil())
                        expect(jsonObjectWithFloatZero.coercedInteger).to(beNil())
                        expect(jsonObjectWithFloatOne.coercedInteger).to(beNil())
                        expect(jsonObjectWithStringZero.coercedInteger).to(beNil())
                        expect(jsonObjectWithStringOne.coercedInteger).to(beNil())
                        expect(jsonObjectWithStringFalse.coercedInteger).to(beNil())
                        expect(jsonObjectWithStringTrue.coercedInteger).to(beNil())
                    }
                }
            }

            // MARK: coercedFloat

            describe("float") {
                describe("from JSON.Null") {
                    it("returns nil") {
                        expect(jsonNull.coercedFloat).to(beNil())
                    }
                }

                describe("from JSON.Boolean") {
                    it("returns 1 for true") {
                        expect(jsonTrue.coercedFloat) == 1.0
                    }

                    it("returns 0 for false") {
                        expect(jsonFalse.coercedFloat) == 0.0
                    }
                }

                describe("from JSON.Integer") {
                    it("returns the convertion of the wrapped value") {
                        expect(jsonIntZero.coercedFloat) == 0.0
                        expect(jsonIntOne.coercedFloat) == 1.0
                        expect(jsonIntPlusMillion.coercedFloat) == 1_000_000.0
                        expect(jsonIntMinusMillion.coercedFloat) == -1_000_000.0
                    }
                }

                describe("from JSON.Float") {
                    it("returns the wrapped value") {
                        expect(jsonFloatZero.coercedFloat) == 0.0
                        expect(jsonFloatOne.coercedFloat) == 1.0
                        expect(jsonFloatMinusOneAndHalf.coercedFloat) == -1.5
                        expect(jsonFloatPlusOneAndHalf.coercedFloat) == 1.5
                        expect(jsonFloatPlusMillion.coercedFloat) == 1_000_000.0
                        expect(jsonFloatMinusMillion.coercedFloat) == -1_000_000.0
                        expect(jsonFloatPlusMillionAndQuarter.coercedFloat) == 1_000_000.25
                        expect(jsonFloatMinusMillionAndQuarter.coercedFloat) == -1_000_000.25
                        expect(jsonFloatPlusTenPowerHundred.coercedFloat) == 1e100
                        expect(josnFloatMinutTenPowerHundred.coercedFloat) == -1e100
                    }
                }

                describe("from JSON.String") {
                    it("converts into floating-point where possible") {
                        expect(jsonStringZero.coercedFloat) == 0.0
                        expect(jsonStringPlusMillion.coercedFloat) == 1_000_000.0
                        expect(jsonStringMinusMillion.coercedFloat) == -1_000_000.0
                        expect(jsonStringPlusOneAndHalf.coercedFloat) == 1.5
                        expect(jsonStringMinusOneAndHalf.coercedFloat) == -1.5
                        expect(jsonStringPlusTenPowerThirty.coercedFloat) == 1e30
                        expect(josnStringMinutTenPowerThirty.coercedFloat) == -1e30
                        expect(jsonStringPlusTenPowerHundred.coercedFloat) == 1e100
                        expect(josnStringMinutTenPowerHundred.coercedFloat) == -1e100
                    }

                    it("returns nil when conversion into floating-point is not possible") {
                        expect(jsonStringEmpty.coercedFloat).to(beNil())
                        expect(jsonStringLorem.coercedFloat).to(beNil())
                        expect(jsonStringWhitespace.coercedFloat).to(beNil())
                        expect(jsonStringTrue.coercedFloat).to(beNil())
                        expect(jsonStringFalse.coercedFloat).to(beNil())
                        expect(jsonStringEmpty.coercedFloat).to(beNil())
                        expect(jsonStringEmpty.coercedFloat).to(beNil())
                    }
                }

                describe("from JSON.Array") {
                    it("returns nil") {
                        expect(jsonArrayWithNothing.coercedFloat).to(beNil())
                        expect(jsonArrayWithTrue.coercedFloat).to(beNil())
                        expect(jsonArrayWithFalse.coercedFloat).to(beNil())
                        expect(jsonArrayWithIntegerZero.coercedFloat).to(beNil())
                        expect(jsonArrayWithIntegerOne.coercedFloat).to(beNil())
                        expect(jsonArrayWithFloatZero.coercedFloat).to(beNil())
                        expect(jsonArrayWithFloatOne.coercedFloat).to(beNil())
                        expect(jsonArrayWithStringZero.coercedFloat).to(beNil())
                        expect(jsonArrayWithStringOne.coercedFloat).to(beNil())
                        expect(jsonArrayWithStringTrue.coercedFloat).to(beNil())
                        expect(jsonArrayWithStringFalse.coercedFloat).to(beNil())
                    }
                }

                describe("from JSON.Object") {
                    it("returns nil") {
                        expect(jsonObjectWithNothing.coercedFloat).to(beNil())
                        expect(jsonObjectWithTrue.coercedFloat).to(beNil())
                        expect(jsonObjectWithFalse.coercedFloat).to(beNil())
                        expect(jsonObjectWithIntegerZero.coercedFloat).to(beNil())
                        expect(jsonObjectWithIntegerOne.coercedFloat).to(beNil())
                        expect(jsonObjectWithFloatZero.coercedFloat).to(beNil())
                        expect(jsonObjectWithFloatOne.coercedFloat).to(beNil())
                        expect(jsonObjectWithStringZero.coercedFloat).to(beNil())
                        expect(jsonObjectWithStringOne.coercedFloat).to(beNil())
                        expect(jsonObjectWithStringFalse.coercedFloat).to(beNil())
                        expect(jsonObjectWithStringTrue.coercedFloat).to(beNil())
                    }
                }
            }

            // MARK: coercedString

            describe("string") {
                describe("from JSON.Null") {
                    it("returns null") {
                        expect(jsonNull.coercedString) == "null"
                    }
                }

                describe("from JSON.Boolean") {
                    it("returns true for true") {
                        expect(jsonTrue.coercedString) == "true"
                    }

                    it("returns false for false") {
                        expect(jsonFalse.coercedString) == "false"
                    }
                }

                describe("from JSON.Integer") {
                    it("returns text representation of the wrapped number") {
                        expect(jsonIntZero.coercedString) == "0"
                        expect(jsonIntOne.coercedString) == "1"
                        expect(jsonIntPlusMillion.coercedString) == "1000000"
                        expect(jsonIntMinusMillion.coercedString) == "-1000000"
                    }
                }

                describe("from JSON.Float") {
                    it("returns text representation of the wrapped number") {
                        expect(jsonFloatZero.coercedString) == "0.0"
                        expect(jsonFloatOne.coercedString) == "1.0"
                        expect(jsonFloatPlusOneAndHalf.coercedString) == "1.5"
                        expect(jsonFloatMinusOneAndHalf.coercedString) == "-1.5"
                        expect(jsonFloatPlusMillion.coercedString) == "1000000.0"
                        expect(jsonFloatMinusMillion.coercedString) == "-1000000.0"
                        expect(jsonFloatPlusMillionAndQuarter.coercedString) == "1000000.25"
                        expect(jsonFloatMinusMillionAndQuarter.coercedString) == "-1000000.25"
                        expect(jsonFloatPlusTenPowerHundred.coercedString) == "1e+100"
                        expect(josnFloatMinutTenPowerHundred.coercedString) == "-1e+100"
                    }
                }

                describe("from JSON.String") {
                    it("returns the wrapped value") {
                        expect(jsonStringEmpty.coercedString) == ""
                        expect(jsonStringLorem.coercedString) == "Lorem"
                        expect(jsonStringWhitespace.coercedString) == " \n\r \t \n \t \r \t \r\n "
                        expect(jsonStringTrue.coercedString) == "true"
                        expect(jsonStringFalse.coercedString) == "false"
                        expect(jsonStringZero.coercedString) == "0"
                        expect(jsonStringPlusMillion.coercedString) == "1000000"
                        expect(jsonStringMinusMillion.coercedString) == "-1000000"
                        expect(jsonStringPlusOneAndHalf.coercedString) == "1.5"
                        expect(jsonStringMinusOneAndHalf.coercedString) == "-1.5"
                        expect(jsonStringPlusTenPowerThirty.coercedString) == "1000000000000000000000000000000"
                        expect(josnStringMinutTenPowerThirty.coercedString) == "-1000000000000000000000000000000"
                        expect(jsonStringPlusTenPowerHundred.coercedString) == "1e100"
                        expect(josnStringMinutTenPowerHundred.coercedString) == "-1e100"
                    }
                }

                describe("from JSON.Array") {
                    it("returns nil") {
                        expect(jsonArrayWithNothing.coercedString).to(beNil())
                        expect(jsonArrayWithTrue.coercedString).to(beNil())
                        expect(jsonArrayWithFalse.coercedString).to(beNil())
                        expect(jsonArrayWithIntegerZero.coercedString).to(beNil())
                        expect(jsonArrayWithIntegerOne.coercedString).to(beNil())
                        expect(jsonArrayWithFloatZero.coercedString).to(beNil())
                        expect(jsonArrayWithFloatOne.coercedString).to(beNil())
                        expect(jsonArrayWithStringZero.coercedString).to(beNil())
                        expect(jsonArrayWithStringOne.coercedString).to(beNil())
                        expect(jsonArrayWithStringTrue.coercedString).to(beNil())
                        expect(jsonArrayWithStringFalse.coercedString).to(beNil())
                    }
                }

                describe("from JSON.Object") {
                    it("returns nil") {
                        expect(jsonObjectWithNothing.coercedString).to(beNil())
                        expect(jsonObjectWithTrue.coercedString).to(beNil())
                        expect(jsonObjectWithFalse.coercedString).to(beNil())
                        expect(jsonObjectWithIntegerZero.coercedString).to(beNil())
                        expect(jsonObjectWithIntegerOne.coercedString).to(beNil())
                        expect(jsonObjectWithFloatZero.coercedString).to(beNil())
                        expect(jsonObjectWithFloatOne.coercedString).to(beNil())
                        expect(jsonObjectWithStringZero.coercedString).to(beNil())
                        expect(jsonObjectWithStringOne.coercedString).to(beNil())
                        expect(jsonObjectWithStringFalse.coercedString).to(beNil())
                        expect(jsonObjectWithStringTrue.coercedString).to(beNil())
                    }
                }
            }
        }
    }
    
}
