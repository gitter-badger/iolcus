//
//  TestDecodable.swift
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

import Medea
import XCTest

struct Book {
    let title       : String
    let authors     : [String]
    let volume      : Int
    let isPaperback : Bool
}

extension Book: JSONEncodable {
    
    func encodeJSON() -> JSON {
        let jsonBook: JSON = [
            "title"       : title,
            "volume"      : volume,
            "isPaperback" : isPaperback,
            "authors"     : JSON(encodable: authors)
        ]
        return jsonBook
    }
    
}

extension Book: JSONDecodable {
    
    init(json: JSON) throws {
        // title = try String(json: json["title"])
        title = try String(json: json, at: "title")
        volume = try Int(json: json["volume"])
        authors = try Array(json: json["authors"])
        isPaperback = try Bool(json: json["isPaperback"])
    }
    
}

class MedeaTestDecodable: XCTestCase {


    func testTest() {
        
        let book = Book(
            title       : "War and Peace",
            authors     : ["Tolstoy, Leo", "Leo Tolstoy"],
            volume      : 1,
            isPaperback : false
        )
        
        let jsonBook = JSON(encodable: book)
        
        let serializedBook = JSONSerialization.makeString(json: jsonBook)

        let anotherJSONBook = try! JSONDeserialization.makeJSON(string: serializedBook)

        let newBook = try! Book(json: anotherJSONBook)
        
        print(book, newBook, separator: "\n")
        
    }
    
}
