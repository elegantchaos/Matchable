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
let x, y: Int
try x.assertMatches(y)
```

A sequence of checks can easily be performed -- the first failure with throw, causing the remaining checks to be skipped:

```
try int1.assertMatches(int2)
try double1.assertMatches(double2)
try string1.assertMatches(string2)
```

A type can implement matching by conforming to the `Matchable` protocol, and defining the `assertMatches` method. Inside this method it can perform the necessary checks. If it finds a failure, it can throw a `MatchFailedError` to report the mismatch.

Although you can match primitive value types, the protocol comes into its own when performing memberwise matching of compound types (structs, objects, etc).

In this case a type can conform to the `MatchableCompound` protocol, and defining the `assertContentMatches` method.

This works the same way as the basic `assertMatches` method, except that if a check throws an error inside this method, the error will be wrapped in an outer error reporting that the whole structure failed to match.

## Matching Keypaths

As a convenience, we also define a form of `assertMatches` which takes a key path or list of key paths, and calls `assertMatches` on each path of two objects in turn.

This helps to keep down the amount of boiler-plate code to a minimum.

_Note that currently if you pass a list of keys, they all have to resolve to members of the same type. Unfortunately this somewhat reduces the helpfulness of this method._


## Unit Testing

The original motivating use-case for this protocol was unit testing, where it's often necessary to compare two instances of something, and useful to be able to identify the exact point of divergence.

The fact that `Matchable` is different from `Equatable` is also an advantage here, as it allows both to co-exist. 

In your code, you might define `Equatable` to only check part of a structure (a unique identifier, for example).

This is good for efficiency in production code, but no use for test code where you really do want to know if all members are equal.

In this situation you can define a thorough check with `Matchable`, without interfering with the efficient implemention of `Equatable`.

Initially this protocol was defined as part of my [XCTestExtensions](https://github.com/elegantchaos/XCTestExtensions) package. However, I realised that it might have wider application, so have now split it out into this package.
