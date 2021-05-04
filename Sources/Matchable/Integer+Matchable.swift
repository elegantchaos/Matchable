// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 29/04/21.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

extension BinaryInteger {
    public func assertMatches(_ other: Self, in context: MatchableContext) throws {
        if self != other {
            throw MatchFailedError("\(self) != \(other)", value: self, expected: other, context: context)
        }
    }
}

extension Int: Matchable {
}

extension Int8: Matchable {
}

extension Int16: Matchable {
}

extension Int32: Matchable {
}

extension Int64: Matchable {
}

extension UInt: Matchable {
}

extension UInt8: Matchable {
}

extension UInt16: Matchable {
}

extension UInt32: Matchable {
}

extension UInt64: Matchable {
}

