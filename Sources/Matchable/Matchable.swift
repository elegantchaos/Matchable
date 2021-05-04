// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 29/04/21.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

/// Items adopting this protocol support the `assertMatches` method, which
/// (as the name suggests) asserts that the item matches another item of the
/// same type.
///
/// Typically this is expected to mean that the two items are identical, but it's
/// up to your implementation to determine that.

public protocol Matchable {
    func assertMatches(_ other: Self, in context: MatchableContext) throws
}


/// Protocol for the context of the match assertion.
/// The context should include the line and file location
/// of the match, for use with debugging and logging failures.
///
/// The context also includes options which can modify the behaviour of the match,
/// such as whether to take account of case sensitivity when matching text.

public protocol MatchableContext {
    var file: StaticString { get }
    var line: UInt { get }
    var options: MatchOptions { get }
}



/// Simple concrete implementation of the MatchableContext
/// which just stores the three required values.
/// Generally this should be sufficient, but you can substitute other
/// structures with more information as long as they implement the protocol.

public struct MatchContext: MatchableContext {
    public let options: MatchOptions
    public let file: StaticString
    public let line: UInt

    public init(options: MatchOptions, file: StaticString, line: UInt) {
        self.options = options
        self.file = file
        self.line = line
    }
}


/// Options that can be used to modify the behaviour of the matching.
public struct MatchOptions: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let ignoringWhitespace = Self(rawValue: 1 << 0)
    public static let `default`: MatchOptions = []
}



public extension Matchable {
    
    
    /// Assert that a given keypath on this object matches another one.
    /// - Parameters:
    ///   - key: the key to check
    ///   - other: the other object
    ///   - context: the context we're matching in
    /// - Throws: an error if they don't match
    func assertMatches<F>(_ key: KeyPath<Self, F>, of other: Self, context: MatchableContext) throws where F: Matchable {
        let a = self[keyPath: key]
        let b = other[keyPath: key]
        try a.assertMatches(b, in: context)
    }
    
    /// Assert that a group of key paths on this object all match the corresponding values on another one.
    /// - Parameters:
    ///   - keys: the keys to check
    ///   - other: the other object
    ///   - context: the context we're matching in
    /// - Throws: an error if any of the keys fail to match
    func assertMatches<F>(_ keys: [KeyPath<Self, F>], of other: Self, context: MatchableContext) throws where F: Matchable {
        for key in keys {
            let a = self[keyPath: key]
            let b = other[keyPath: key]
            try a.assertMatches(b, in: context)
        }
    }
    
    /// Assert that this object matches another one
    /// - Parameters:
    ///   - other: the other object
    ///   - options: options for the matching
    ///   - file: the file to report any failure as coming from
    ///   - line: the line to report any failure as coming from
    /// - Throws: an error if we fail to match
    func assertMatches(_ other: Self, options: MatchOptions = .default, file: StaticString = #file, line: UInt = #line) throws {
        try assertMatches(other, in: MatchContext(options: options, file: file, line: line))
    }
    
    /// Assert that a given keypath on this object matches another one.
    /// - Parameters:
    ///   - key: the key to check
    ///   - other: the other object
    ///   - options: options for the matching
    ///   - file: the file to report any failure as coming from
    ///   - line: the line to report any failure as coming from
    /// - Throws: an error if they don't match
    func assertMatches<F>(_ key: KeyPath<Self, F>, of other: Self, options: MatchOptions = .default, file: StaticString = #file, line: UInt = #line) throws where F: Matchable {
        try assertMatches(key, of: other, context: MatchContext(options: options, file: file, line: line))
    }
    
    /// Assert that a group of key paths on this object all match the corresponding values on another one.
    /// - Parameters:
    ///   - keys: the keys to check
    ///   - other: the other object
    ///   - options: options for the matching
    ///   - file: the file to report any failure as coming from
    ///   - line: the line to report any failure as coming from
    /// - Throws: an error if any of the keys fail to match
    func assertMatches<F>(_ keys: [KeyPath<Self, F>], of other: Self, options: MatchOptions = .default, file: StaticString = #file, line: UInt = #line) throws where F: Matchable {
        try assertMatches(keys, of: other, context: MatchContext(options: options, file: file, line: line))
    }
    
    /// Perform some checks. If they throw a MatchFailedError, wrap it in another error
    /// and throw that; otherwise just re-throw the original error.
    /// - Parameters:
    ///   - message: The message to use for the wrapping error.
    ///   - other: The object we're comparing (will be passed to the wrapping error)
    ///   - context: Context of the comparison.
    ///   - checks: The checks to perform. This can be any code, but typically is expected to be one or more `assertMatches` calls.
    /// - Throws: An error if any of the checks fail.
    func assertWrappedChecksMatch(_ message: String? = nil, of other: Self, in context: MatchableContext, checks: () throws -> Void) throws {
        do {
            try checks()
        } catch {
            if let error = error as? MatchFailedErrorBase {
                let detail = message ?? "\(Self.self) instances failed to match"
                throw MatchFailedError(detail, value: self, expected: other, underlyingError: error, context: context)
            } else {
                throw error
            }
        }
    }
}
