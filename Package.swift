// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppleMusicKit",
    platforms: [.iOS("11.0"), .macOS(SupportedPlatform.MacOSVersion.v10_12)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "AppleMusicKit", targets: ["AppleMusicKit"])],
    dependencies: [],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "AppleMusicKit",
            dependencies: [],
            resources: [
                .process("Resources/Mocks/APIError.json"),
                .process("Resources/Mocks/APIErrorInvalid.json"),
                .process("Resources/Mocks/CatalogSong.json"),
                .process("Resources/Mocks/CatalogSongInvalid.json")
            ]
        ),
        .testTarget(
            name: "AppleMusicKitTests",
            dependencies: ["AppleMusicKit"]),
    ]
)
