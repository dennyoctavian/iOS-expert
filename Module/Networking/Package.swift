// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dennyoctavian/Modularization-Core-Package.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [
                .product(name: "Core", package: "Modularization-Core-Package")
            ]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]),
    ]
)
