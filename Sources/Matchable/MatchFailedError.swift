// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 04/05/21.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

/// Base protocol for any errors thrown as the result of a match failing.

public protocol MatchFailedErrorBase: Error {
    var detail: String { get }
    var context: MatchableContext { get }
    var underlyingError: MatchFailedErrorBase? { get }
}


/// Specific failure error for a given type. Includes a detailed
/// description of the failure, as well as the actual and expected values
/// that were matched.
///
/// If an embedded member of a structure failed, the error can be wrapped
/// up in another error for the structure as a whole, and thrown again.

public struct MatchFailedError<T>: MatchFailedErrorBase {
    public init(_ detail: String, value: T, expected: T, underlyingError: MatchFailedErrorBase? = nil, context: MatchableContext) {
        self.detail = detail
        self.value = value
        self.expected = expected
        self.context = context
        self.underlyingError = underlyingError
    }
    
    public let detail: String
    public let value: T
    public let expected: T
    public let context: MatchableContext
    public let underlyingError: MatchFailedErrorBase?
}


/// Readable description of the error.

extension MatchFailedError: CustomStringConvertible {
    public var description: String {
        let url = URL(fileURLWithPath: String(stringLiteral: context.file.description))
        let h = "Matching failed at line \(context.line) of \(url.lastPathComponent)."
        let s = String(repeating: "-", count: h.count)
        return "\n\n\(s)\n\(h)\n\(s)\n\n\(detail)\n\n\(value)\n\n-- instead of --\n\n\(expected)\npath: \(context.file)\n\n"
    }
}
