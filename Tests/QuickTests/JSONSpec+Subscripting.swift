//
//  JSONSpect+Subscripting.swift
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

    func specSubscripting() {
        describe("subscript") {
            describe("with an integer index") {
                context("for JSON.Null") {
                    var json: JSON = nil
                    describe("subscript getter") {
                        it("returns JSON.Null") {
                            expect(json[0]) == JSON.Null
                        }
                    }
                    describe("explicit getter") {
                        it("returns JSON.Null") {
                            expect(json.getValue(at: 0)) == JSON.Null
                        }
                    }
                    describe("explicit setter") {
                        it("fails with error ") {
                            expect { try json.setValue(at: 0, value: .Null) }
                                .to(throwError(errorType: JSON.Error.Subscrpting.self))
                        }
                    }
                }

                context("for JSON.Boolean") {
                    var json: JSON = true
                    describe("subscript getter") {
                        it("returns JSON.Null") {
                            expect(json[0]) == JSON.Null
                        }
                    }
                    describe("explicit getter") {
                        it("returns JSON.Null") {
                            expect(json.getValue(at: 0)) == JSON.Null
                        }
                    }
                    describe("explicit setter") {
                        it("fails with error ") {
                            expect { try json.setValue(at: 0, value: .Null) }
                                .to(throwError(errorType: JSON.Error.Subscrpting.self))
                        }
                    }
                }

                context("for JSON.Integer") {
                    var json: JSON = 0
                    describe("subscript getter") {
                        it("returns JSON.Null") {
                            expect(json[0]) == JSON.Null
                        }
                    }
                    describe("explicit getter") {
                        it("returns JSON.Null") {
                            expect(json.getValue(at: 0)) == JSON.Null
                        }
                    }
                    describe("explicit setter") {
                        it("fails with error ") {
                            expect { try json.setValue(at: 0, value: .Null) }
                                .to(throwError(errorType: JSON.Error.Subscrpting.self))
                        }
                    }
                }

                context("for JSON.Float") {
                    var json: JSON = 0.0
                    describe("subscript getter") {
                        it("returns JSON.Null") {
                            expect(json[0]) == JSON.Null
                        }
                    }
                    describe("explicit getter") {
                        it("returns JSON.Null") {
                            expect(json.getValue(at: 0)) == JSON.Null
                        }
                    }
                    describe("explicit setter") {
                        it("fails with error ") {
                            expect { try json.setValue(at: 0, value: .Null) }
                                .to(throwError(errorType: JSON.Error.Subscrpting.self))
                        }
                    }
                }

                context("for JSON.String") {
                    var json: JSON = "Lorem"
                    describe("subscript getter") {
                        it("returns JSON.Null") {
                            expect(json[0]) == JSON.Null
                        }
                    }
                    describe("explicit getter") {
                        it("returns JSON.Null") {
                            expect(json.getValue(at: 0)) == JSON.Null
                        }
                    }
                    describe("explicit setter") {
                        it("fails with error ") {
                            expect { try json.setValue(at: 0, value: .Null) }
                                .to(throwError(errorType: JSON.Error.Subscrpting.self))
                        }
                    }
                }

                context("for JSON.Array") {
                    describe("subscript getter") {
                        var json: JSON = [false, 0, 0.0, "false"]

                        context("when index is out of bounds") {
                            it("returns JSON.Null") {
                                expect(json[-1]) == JSON.Null
                                expect(json[4]) == JSON.Null
                            }
                        }
                        context("when index is within bounds") {
                            it("returns an element at given position") {
                                expect(json[0]) == JSON.Boolean(false)
                                expect(json[1]) == JSON.Integer(0)
                                expect(json[2]) == JSON.Float(0.0)
                                expect(json[3]) == JSON.String("false")
                            }
                        }
                    }
                    describe("explicit getter") {
                        let json: JSON = [false, 0, 0.0, "false"]

                        context("when index is out of bounds") {
                            it("returns JSON.Null") {
                                expect(json.getValue(at: -1)) == JSON.Null
                                expect(json.getValue(at: 4)) == JSON.Null
                            }
                        }
                        context("when index is within bounds") {
                            it("returns an element at given position") {
                                expect(json.getValue(at: 0)) == JSON.Boolean(false)
                                expect(json.getValue(at: 1)) == JSON.Integer(0)
                                expect(json.getValue(at: 2)) == JSON.Float(0.0)
                                expect(json.getValue(at: 3)) == JSON.String("false")
                            }
                        }
                    }
                    describe("subscript setter") {
                        var json: JSON = [false, 0, 0.0, "false"]

                        context("when index is within bounds") {
                            it("sets the value at given position") {
                                json[0] = true
                                json[1] = 1
                                json[2] = 1.0
                                json[3] = "true"

                                expect(json[0]) == JSON.Boolean(true)
                                expect(json[1]) == JSON.Integer(1)
                                expect(json[2]) == JSON.Float(1.0)
                                expect(json[3]) == JSON.String("true")
                            }
                        }
                    }
                    describe("explicit setter") {
                        var json: JSON = [false, 0, 0.0, "false"]

                        context("when index is within bounds") {
                            it("sets the value at given position within bounds") {
                                expect { try json.setValue(at: 0, value: true) }
                                    .notTo(throwError())

                                expect { try json.setValue(at: 1, value: 1) }
                                    .notTo(throwError())

                                expect { try json.setValue(at: 2, value: 1.0) }
                                    .notTo(throwError())

                                expect { try json.setValue(at: 3, value: "true") }
                                    .notTo(throwError())

                                expect(json[0]) == JSON.Boolean(true)
                                expect(json[1]) == JSON.Integer(1)
                                expect(json[2]) == JSON.Float(1.0)
                                expect(json[3]) == JSON.String("true")
                            }
                        }
                        context("when index is out of bounds") {
                            it("fails") {
                                expect { try json.setValue(at: -1, value: nil) }
                                    .to(throwError(errorType: JSON.Error.Subscrpting.self))

                                expect { try json.setValue(at: 4, value: nil) }
                                    .to(throwError(errorType: JSON.Error.Subscrpting.self))
                            }
                        }
                    }
                }

                context("for JSON.Object") {
                    var json: JSON = ["0": "Lorem"]
                    describe("subscript getter") {
                        it("returns JSON.Null") {
                            expect(json[0]) == JSON.Null
                        }
                    }
                    describe("explicit getter") {
                        it("returns JSON.Null") {
                            expect(json.getValue(at: 0)) == JSON.Null
                        }
                    }
                    describe("explicit setter") {
                        it("fails with error ") {
                            expect { try json.setValue(at: 0, value: .Null) }
                                .to(throwError(errorType: JSON.Error.Subscrpting.self))
                        }
                    }
                }
            }

            describe("with a string index") {
                context("for JSON.Null") {
                    var json: JSON = nil
                    describe("subscript getter") {
                        it("returns JSON.Null") {
                            expect(json[""]) == JSON.Null
                        }
                    }
                    describe("explicit getter") {
                        expect(json.getValue(at: "")) == JSON.Null
                    }
                    describe("explicit setter") {
                        it("fails with error ") {
                            expect { try json.setValue(at: "", value: .Null) }
                                .to(throwError(errorType: JSON.Error.Subscrpting.self))
                        }
                    }
                }

                context("for JSON.Boolean") {
                    var json: JSON = true
                    describe("subscript getter") {
                        it("returns JSON.Null") {
                            expect(json[""]) == JSON.Null
                        }
                    }
                    describe("explicit getter") {
                        expect(json.getValue(at: "")) == JSON.Null
                    }
                    describe("explicit setter") {
                        it("fails with error ") {
                            expect { try json.setValue(at: "", value: .Null) }
                                .to(throwError(errorType: JSON.Error.Subscrpting.self))
                        }
                    }
                }

                context("for JSON.Integer") {
                    var json: JSON = 0
                    describe("subscript getter") {
                        it("returns JSON.Null") {
                            expect(json[""]) == JSON.Null
                        }
                    }
                    describe("explicit getter") {
                        expect(json.getValue(at: "")) == JSON.Null
                    }
                    describe("explicit setter") {
                        it("fails with error ") {
                            expect { try json.setValue(at: "", value: .Null) }
                                .to(throwError(errorType: JSON.Error.Subscrpting.self))
                        }
                    }
                }

                context("for JSON.Float") {
                    var json: JSON = 0.0
                    describe("subscript getter") {
                        it("returns JSON.Null") {
                            expect(json[""]) == JSON.Null
                        }
                    }
                    describe("explicit getter") {
                        expect(json.getValue(at: "")) == JSON.Null
                    }
                    describe("explicit setter") {
                        it("fails with error ") {
                            expect { try json.setValue(at: "", value: .Null) }
                                .to(throwError(errorType: JSON.Error.Subscrpting.self))
                        }
                    }
                }

                context("for JSON.String") {
                    var json: JSON = "Lorem"
                    describe("subscript getter") {
                        it("returns JSON.Null") {
                            expect(json[""]) == JSON.Null
                        }
                    }
                    describe("explicit getter") {
                        expect(json.getValue(at: "")) == JSON.Null
                    }
                    describe("explicit setter") {
                        it("fails with error ") {
                            expect { try json.setValue(at: "", value: .Null) }
                                .to(throwError(errorType: JSON.Error.Subscrpting.self))
                        }
                    }
                }

                context("for JSON.Array") {
                    var json: JSON = [false, 0, 0.0, "false"]
                    describe("subscript getter") {
                        it("returns JSON.Null") {
                            expect(json[""]) == JSON.Null
                        }
                    }
                    describe("explicit getter") {
                        expect(json.getValue(at: "")) == JSON.Null
                    }
                    describe("explicit setter") {
                        it("fails with error ") {
                            expect { try json.setValue(at: "", value: .Null) }
                                .to(throwError(errorType: JSON.Error.Subscrpting.self))
                        }
                    }
                }

                context("for JSON.Object") {
                    describe("subscript getter") {
                        let json: JSON = ["flag": false, "count": 1, "weight": 2.0, "quote": "Ook"]

                        context("when such index does not exist") {
                            it("returns JSON.Null") {
                                expect(json["FLAG"]) == JSON.Null
                            }
                        }
                        context("when such index does exist") {
                            it("returns an element at given index") {
                                expect(json["flag"]) == JSON.Boolean(false)
                                expect(json["count"]) == JSON.Integer(1)
                                expect(json["weight"]) == JSON.Float(2.0)
                                expect(json["quote"]) == JSON.String("Ook")
                            }
                        }
                    }
                    describe("explicit getter") {
                        let json: JSON = ["flag": false, "count": 1, "weight": 2.0, "quote": "Ook"]

                        context("when such index does not exist") {
                            it("returns JSON.Null") {
                                expect(json.getValue(at: "FLAG")) == JSON.Null
                            }
                        }
                        context("when such index does exist") {
                            it("returns an element at given index") {
                                expect(json.getValue(at: "flag")) == JSON.Boolean(false)
                                expect(json.getValue(at: "count")) == JSON.Integer(1)
                                expect(json.getValue(at: "weight")) == JSON.Float(2.0)
                                expect(json.getValue(at: "quote")) == JSON.String("Ook")
                            }
                        }
                    }
                    describe("subscript setter") {
                        var json: JSON = ["flag": false, "count": 1, "weight": 2.0, "quote": "Ook"]

                        it("sets the value at given index") {
                            json["flag"] = true
                            json["count"] = 2
                            json["weight"] = 22.0
                            json["quote"] = "Eek"
                            json["quote 2"] = "Ook"

                            expect(json["flag"]) == JSON.Boolean(true)
                            expect(json["count"]) == JSON.Integer(2)
                            expect(json["weight"]) == JSON.Float(22.0)
                            expect(json["quote"]) == JSON.String("Eek")
                            expect(json["quote 2"]) == JSON.String("Ook")
                        }
                    }
                    describe("explicit setter") {
                        var json: JSON = ["flag": false, "count": 1, "weight": 2.0, "quote": "Ook"]

                        it("sets the value at given index") {
                            expect { try json.setValue(at: "flag", value: true) }
                                .notTo(throwError())

                            expect { try json.setValue(at: "count", value: 2) }
                                .notTo(throwError())

                            expect { try json.setValue(at: "weight", value: 22.0) }
                                .notTo(throwError())

                            expect { try json.setValue(at: "quote", value: "Eek") }
                                .notTo(throwError())

                            expect { try json.setValue(at: "quote 2", value: "Ook") }
                                .notTo(throwError())

                            expect(json["flag"]) == JSON.Boolean(true)
                            expect(json["count"]) == JSON.Integer(2)
                            expect(json["weight"]) == JSON.Float(22.0)
                            expect(json["quote"]) == JSON.String("Eek")
                            expect(json["quote 2"]) == JSON.String("Ook")
                        }
                    }
                }
            }
        }
    }
    
}
