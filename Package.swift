// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftAnimeGAN",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftAnimeGAN",
            targets: ["SwiftAnimeGAN"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftAnimeGAN",
            resources: [
            .process("animeganHayao.mlmodel")]
    ),
        .testTarget(
            name: "SwiftAnimeGANTests",
            dependencies: ["SwiftAnimeGAN"]),
    ]
)
