// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 29/04/21.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

extension Array: Matchable where Element: Matchable {
    public func assertMatches(_ other: Array<Element>, in context: MatchableContext) throws {
        if count != other.count {
            throw MatchFailedError("Counts differ for \(Self.self)", value: count, expected: other.count, context: context)
        }

        try count.assertMatches(other.count, in: context)
        for (a,b) in zip(self, other) {
            try a.assertMatches(b, in: context)
        }
    }
}

extension Set: Matchable where Element: Matchable {
    public func assertMatches(_ other: Set<Element>, in context: MatchableContext) throws {
        if self != other {
            throw MatchFailedError("Contents differ for \(Self.self).", value: self, expected: other, context: context)
            // TODO: report more about the exact difference - eg first non-matching element
        }
    }
}

extension Dictionary: Matchable where Value: Equatable {
    public func assertMatches(_ other: Dictionary, in context: MatchableContext) throws {
        if self != other {
            throw MatchFailedError("Contents differ for \(Self.self).", value: self, expected: other, context: context)
            // TODO: report more about the exact difference - eg first non-matching key
        }
    }
}
