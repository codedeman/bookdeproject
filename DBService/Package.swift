// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DBService",
    platforms: [
        .iOS(.v15),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "DBService",
            targets: ["DBService"]),
        .library(
            name: "DBFireBaseService",
            targets: ["DBFireBaseService"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            .upToNextMajor(from: "10.4.0")
        ),
    ],
    targets: [
        .target(
            name: "DBService",
            dependencies: ["DBFireBaseService"]),
        .target(
            name: "DBFireBaseService",
            dependencies: [
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseStorage", package: "firebase-ios-sdk"),
            ]),
        .testTarget(
            name: "DBServiceTests",
            dependencies: ["DBService"]),
    ]
)
