// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Chart",
    platforms: [.iOS(.v14), .macOS(.v10_14)],
    products: [
        .library(
            name: "Chart",
            targets: ["Chart"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Chart",
            dependencies: []),
        .testTarget(
            name: "ChartTests",
            dependencies: ["Chart"]),
    ]
)
