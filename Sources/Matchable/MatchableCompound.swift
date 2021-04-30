// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/04/21.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

public protocol MatchableCompound: Matchable {
    func assertContentMatches(_ other: Self, in context: MatchableContext) throws
}

public extension MatchableCompound {
    func assertMatches(_ other: Self, in context: MatchableContext) throws {
        try assertWrappedChecksMatch(of: other, in: context) {
            try assertContentMatches(other, in: context)
        }
    }
}
