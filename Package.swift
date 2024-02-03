import PackageDescription

let package = Package(
    name: "SwiftAnimeGANv2",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftAnimeGANv2",
            targets: ["SwiftAnimeGANv2"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftAnimeGANv2",
            resources: [
            .process("animeganHayao.mlmodelc")]
    ),
        .testTarget(
            name: "SwiftAnimeGANv2Tests",
            dependencies: ["SwiftAnimeGANv2"]),
    ]
)
