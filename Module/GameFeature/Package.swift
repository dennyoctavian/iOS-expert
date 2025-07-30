// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "GameFeature",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "GameFeature",
            targets: ["GameFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dennyoctavian/Modularization-Core-Package.git", .upToNextMajor(from: "1.0.0")),
        .package(path: "../Networking"),
        .package(path: "../GameDetailFeature")
    ],
    targets: [
        .target(
            name: "GameFeature",
            dependencies: [
                .product(name: "Core", package: "Modularization-Core-Package"),
                .product(name: "Networking", package: "Networking"),
                .product(name: "GameDetailFeature", package: "GameDetailFeature")
            ]
        ),
        .testTarget(
            name: "GameFeatureTests",
            dependencies: ["GameFeature"]),
    ]
)
