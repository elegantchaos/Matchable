// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 29/04/21.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

extension Bool: Matchable {
    public func assertMatches(_ other: Bool, in context: MatchableContext) throws {
        if self != other {
            throw MatchFailedError("Bool values don't match.", value: self, expected: other, context: context)
        }
    }
}
