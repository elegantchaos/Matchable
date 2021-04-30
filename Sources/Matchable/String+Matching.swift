// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 29/04/21.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

/// Check that two strings are equal.
/// If the strings don't match, this function compares them line by line to produce a more accurate description of the place where they differ.
/// It optionally ignores whitespace at the beginning/end of each line.
extension String: Matchable {
    public func assertMatches(_ expected: String, in context: MatchableContext) throws {
        func failure(_ message: String) -> MatchFailedError<String> {
            return MatchFailedError(message, value: self, expected: expected, context: context)
        }
    
        let ignoringWhitespace = context.options.contains(.ignoringWhitespace)
        if self != expected {
            let lines = self.split(separator: "\n")
            let expectedLines = expected.split(separator: "\n")
            let lineCount = lines.count
            let expectedLineCount = expectedLines.count
            for n in 0 ..< min(lineCount, expectedLineCount) {
                var line = String(lines[n])
                var expectedLine = String(expectedLines[n])
                if ignoringWhitespace {
                    line = line.trimmingCharacters(in: .whitespaces)
                    expectedLine = expectedLine.trimmingCharacters(in: .whitespaces)
                }
                
                if line != expectedLine {
                    throw failure("strings different at line \(n).\n\nwas:\n\n\"\(line)\"\n\nexpected:\n\n\"\(expectedLine)\"\n")
                }
            }
            
            if lineCount < expectedLineCount {
                let missing = expectedLines[lineCount ..< expectedLineCount].joined(separator: "\n")
                throw failure("\(expectedLineCount - lineCount) lines missing from string.\n\n\(missing)")
            } else if lineCount > expectedLineCount {
                let extra = lines[expectedLineCount ..< lineCount].joined(separator: "\n")
                throw failure("\(lineCount - expectedLineCount) extra lines in string.\n\n\(extra)")
            }
        }
    }
}
