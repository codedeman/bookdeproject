// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MessageCenter",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MessageCenter",
            targets: ["MessageCenter"]),

        .library(
            name: "MessageCenterMocks",
            targets: ["MessageCenterMocks"]),
    ],
    dependencies: [
        .package(path: "./Cores/DBService"),
        .package(path: "./Cores/CoreUI"),
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MessageCenter",
            dependencies: [
                .product(name: "DBService", package: "DBService"),
                .product(name: "CoreUI", package: "CoreUI"),
                .product(name: "DBFireBaseService", package: "DBService"),
            ]),
        .target(
            name: "MessageCenterMocks",
            dependencies: [
                "MessageCenter"
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "MessageCenterTests",
            dependencies: ["MessageCenter"]),
    ]
)
