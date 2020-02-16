// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "flux",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "flux",
            targets: ["flux"]),
    ],
    dependencies: [
        .package(path: "../Services"),
        .package(path: "../Models"),
        .package(url: "https://github.com/Dimillian/SwiftUIFlux.git", "0.1.0"..<"0.5.0"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "flux",
            dependencies: ["SwiftUIFlux", "Services", "KeychainAccess", "Models"]),
        .testTarget(
            name: "fluxTests",
            dependencies: ["flux"]),
    ]
)
