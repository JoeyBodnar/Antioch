// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Antioch",
    platforms: [.iOS("11.0"), .macOS(SupportedPlatform.MacOSVersion.v10_12)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Antioch",
            targets: ["Antioch"]),
    ],
    dependencies: [],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Antioch",
            dependencies: []),
        .testTarget(
            name: "AntiochTests",
            dependencies: ["Antioch"]),
    ]
)
