// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Colibri",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "colibri", targets: ["Colibri"]),
        .library(name: "ColibriLibrary", targets: ["ColibriLibrary"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/hummingbird-project/swift-mustache", from: "2.0.0")
    ],
    targets: [
        .executableTarget(
            name: "Colibri",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .target(name: "ColibriLibrary")
            ],
            path: "Executable"
        ),
        .target(
            name: "ColibriLibrary",
            dependencies: [
                .product(name: "Mustache", package: "swift-mustache")
            ],
            path: "Library",
            resources: [
                .copy("Resources")
            ]
        ),
        .testTarget(
            name: "ColibriTests",
            dependencies: [
                .target(name: "ColibriLibrary")
            ],
            path: "Test"
        )
    ]
)
