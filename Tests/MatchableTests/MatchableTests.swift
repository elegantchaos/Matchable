// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/04/2021.
//  All code (c) 2021 - present day, Elegant Chaos.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import XCTest

@testable import Matchable

final class MatchableTests: XCTestCase {
    func testInts() {
        XCTAssertThrowsError(try 1.assertMatches(2))
        XCTAssertNoThrow(try 1.assertMatches(1))
    }
    
    func testDoubles() {
        XCTAssertThrowsError(try 1.12.assertMatches(2.12))
        XCTAssertNoThrow(try 1.23.assertMatches(1.23))
    }
    
    func testStrings() {
        XCTAssertThrowsError(try "foo".assertMatches("bar"))
        XCTAssertNoThrow(try "foo".assertMatches("foo"))
    }
    
    func testBools() {
        XCTAssertThrowsError(try false.assertMatches(true))
        XCTAssertNoThrow(try true.assertMatches(true))
    }
    
    func testDates() {
        let d1 = Date(timeIntervalSince1970: 123456)
        let d2 = Date(timeIntervalSince1970: 1234567)
        XCTAssertThrowsError(try d1.assertMatches(d2))
        XCTAssertNoThrow(try d1.assertMatches(d1))
    }
    
    func testArrays() {
        XCTAssertThrowsError(try [1,2].assertMatches([2,1]))
        XCTAssertNoThrow(try [1,2].assertMatches([1,2]))
    }
    
    func testOptionals() {
        let x: Int? = 1
        let y: Int? = 2
        let n: Int? = nil

        XCTAssertThrowsError(try x.assertMatches(y))
        XCTAssertThrowsError(try x.assertMatches(n))
        XCTAssertThrowsError(try n.assertMatches(y))
        XCTAssertNoThrow(try x.assertMatches(x))
    }
}
