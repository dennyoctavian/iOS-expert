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
        .package(path: "../Core"),
        .package(path: "../Networking"),
        .package(path: "../GameDetailFeature")
    ],
    targets: [
        .target(
            name: "GameFeature",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "Networking", package: "Networking"),
                .product(name: "GameDetailFeature", package: "GameDetailFeature")
            ]
        ),
        .testTarget(
            name: "GameFeatureTests",
            dependencies: ["GameFeature"]),
    ]
)
