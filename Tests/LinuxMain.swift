import XCTest

import MatchableTests

var tests = [XCTestCaseEntry]()
tests += MatchableTests.__allTests()

XCTMain(tests)
