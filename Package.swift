// swift-tools-version:5.1

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/04/2021.
//  All code (c) 2021 - present day, Elegant Chaos.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import PackageDescription

let package = Package(
    name: "Matchable",
    platforms: [
        .macOS(.v10_13), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Matchable",
            targets: ["Matchable"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Matchable",
            dependencies: []),
        .testTarget(
            name: "MatchableTests",
            dependencies: ["Matchable"]),
    ]
)
