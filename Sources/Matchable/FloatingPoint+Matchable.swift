// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 29/04/21.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

extension BinaryFloatingPoint {
    public func assertMatches(_ other: Self, in context: MatchableContext) throws {
        if self != other {
            throw MatchFailedError("\(self) != \(other)", value: self, expected: other, context: context)
        }
    }
}

extension Double: Matchable {
}

extension Float: Matchable {
}
