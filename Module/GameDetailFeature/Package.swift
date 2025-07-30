// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GameDetailFeature",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "GameDetailFeature",
            targets: ["GameDetailFeature"]),
    ],
    dependencies: [
         .package(url: "https://github.com/dennyoctavian/Modularization-Core-Package.git", .upToNextMajor(from: "1.0.0")),
        .package(path: "../Networking"),
    ],
    targets: [
        .target(
            name: "GameDetailFeature",
            dependencies: [
                .product(name: "Core", package: "Modularization-Core-Package"),
                .product(name: "Networking", package: "Networking"),
            ]
        ),
        .testTarget(
            name: "GameDetailFeatureTests",
            dependencies: ["GameDetailFeature"]),
    ]
)
