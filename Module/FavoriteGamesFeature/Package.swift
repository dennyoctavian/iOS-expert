// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FavoriteGamesFeature",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "FavoriteGamesFeature",
            targets: ["FavoriteGamesFeature"]),
    ],
    dependencies: [
        .package(path: "../Core"),
        .package(path: "../Networking"),
        .package(path: "../GameDetailFeature")
    ],
    targets: [
        .target(
            name: "FavoriteGamesFeature",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "Networking", package: "Networking"),
                .product(name: "GameDetailFeature", package: "GameDetailFeature")
            ]
        ),
        .testTarget(
            name: "FavoriteGamesFeatureTests",
            dependencies: ["FavoriteGamesFeature"]),
    ]
)
