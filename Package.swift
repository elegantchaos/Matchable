// swift-tools-version:5.9

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 30/04/2021.
//  All code (c) 2021 - present day, Elegant Chaos.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import PackageDescription

let package = Package(
    name: "Matchable",
    platforms: [
        .macOS(.v10_13), .iOS(.v12), .tvOS(.v12), .watchOS(.v6), .visionOS(.v1),
    ],
    products: [
        .library(
            name: "Matchable",
            targets: ["Matchable"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Matchable",
            dependencies: []),
        .testTarget(
            name: "MatchableTests",
            dependencies: ["Matchable"]),
    ]
)
