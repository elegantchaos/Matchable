# Matchable

The matchable protocol defines a way to compare two objects, structures or values for equality.

Unlike the `Equatable` protocol, `Matchable` works by throwing an error when it encounters a mismatch.

You can view this as an assertion-of-equality. For this reason, the primary method is named `assertMatches`.

This makes for compact code since you don't need to write explicit return statements for every comparison.  

It also allows the protocol to handle compound structures intelligently. If a matching check of a structure fails on one of its members, the matchable code with wrap up the error thrown by the member, and throw another error from the structure.

The catching code can dig down into these compound errors to cleanly report exactly where the mismatch occurred.

## Usage

You can check that two values match with:

```
try x.assertMatches(y)
```

A sequence of checks can easily be performed – the first failure will throw, causing the remaining checks to be skipped:

```
try int1.assertMatches(int2)
try double1.assertMatches(double2)
try string1.assertMatches(string2)
```

A type can implement matching by conforming to the `Matchable` protocol, and defining the `assertMatches` method. Inside this method it can perform the necessary checks. If it finds a failure, it can throw a `MatchFailedError` to report the mismatch.

## Compound Types

Although you can match primitive value types, the protocol comes into its own when performing memberwise matching of compound types (structs, objects, etc).

In this case a type can conform to the `MatchableCompound` protocol, and defining the `assertContentMatches` method.

This works the same way as the basic `assertMatches` method, except that if a check throws an error inside this method, the error will be wrapped in an outer error reporting that the whole structure failed to match.

## Keypaths

As a convenience, we also define a form of `assertMatches` which takes a key path or list of key paths, and calls `assertMatches` on each path of two objects in turn.

This helps to keep down the amount of boiler-plate code to a minimum.

Here's an example combining keypaths and the `MatchableCompound`. This tests the matchability of a structure that has 13 properties, and manages to do it with a minimum of boilerplate.

```swift
extension Task: MatchableCompound {
    public func assertContentMatches(_ other: Task, in context: MatchableContext) throws {
        try assertMatches([\.state], of: other)
        try assertMatches([\.name, \.icon, \.details], of: other)
        try assertMatches([\.started], of: other)
        try assertMatches([\.hasDescription, \.hasDuration, \.isScheduled], of: other)
        try assertMatches([\.duration], of: other)
        try assertMatches([\.scheduledHour, \.scheduledMinute], of: other)
        try assertMatches([\.streaks], of: other)
        try assertMatches([\.restDays], of: other)
    }
}
```

_Note that currently if you pass a list of keys, they all have to resolve to members of the same type. Unfortunately this somewhat reduces the helpfulness of this method._


## Unit Testing

The original motivating use-case for this protocol was unit testing, where it's often necessary to compare two instances of something, and useful to be able to identify the exact point of divergence.

Whilst I still see this as the primary use for the protocol, I have split it out into a standalone package as it may be helpful in other places. 

The fact that `Matchable` is different from `Equatable` is an advantage for unit testing, as it allows both to co-exist. 

In your code, you might define `Equatable` to only check part of a structure (a unique identifier, for example).

This is good for efficiency in production code, but no use for test code where you really do want to know if all members are equal.

In this situation you can define a thorough check with `Matchable`, and use that for unit testing, without interfering with the efficient implemention of `Equatable`.

Initially this protocol was defined as part of my [XCTestExtensions](https://github.com/elegantchaos/XCTestExtensions) package.

That package includes some additions to `XCTAssert` which use `Matchable` to let you perform matching checks:

```
XCTAssert(savedModel, matches: reloadedModel)
```

This assert method catches any errors and presents them in a nice way by calling `XCFail`, identifying the exact point of failure.

Because of the way the match-failure errors are wrapped for compound structures, the method can call `XCFail` at all levels of the failure, which results in Xcode showing an error marker at all levels.

This can be helpful when tracking down a mismatch in a deeply nested structure.

## Future

This is an early implementation, based on code pulled from elsewhere.

The API probably needs tweaking, and the methods definitely need documenting.

I also intend to explore the idea of using Swift's introspection to automatically generate `assertMatches` for structures/classes. 

In theory this should work well, but it's possible that it will hit wrinkles.

**All feedback, suggestions, pull requests and bug reports gratefully received!**
