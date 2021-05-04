// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 04/05/21.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

extension Optional: Matchable where Wrapped: Matchable {
    public func assertMatches(_ other: Optional<Wrapped>, in context: MatchableContext) throws {
        if let a = self, let b = other {
            try a.assertMatches(b, in: context)
        } else if let _ = self {
            throw MatchFailedError("Expected non-nil value", value: self, expected: other, context: context)
        } else if let _ = other {
            throw MatchFailedError("Expected nil value", value: self, expected: other, context: context)
        }
    }
}
