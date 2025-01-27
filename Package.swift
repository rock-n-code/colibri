// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Colibri",
    products: [
        .executable(
            name: "colibri",
            targets: ["Colibri"]
        ),
        .library(
            name: "ColibriLibrary",
            targets: ["ColibriLibrary"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            from: "1.0.0"
        )
    ],
    targets: [
        .executableTarget(
            name: "Colibri",
            dependencies: [
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"
                ),
                .target(name: "ColibriLibrary")
            ],
            path: "Sources/Executable"
        ),
        .target(
            name: "ColibriLibrary",
            dependencies: [],
            path: "Sources/Library"
        ),
        .testTarget(
            name: "ColibriTests",
            dependencies: ["ColibriLibrary"],
            path: "Tests/Library"
        )
    ]
)
