// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppFlow",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AppFlow",
            targets: ["AppFlow"]),
    ],
    dependencies: [
        .package(path: "./Feature/Authenticate"),
        .package(path: "./Feature/Home"),
        .package(path: "./Feature/MessageCenter"),

        .package(path: "./DBService"),
        .package(path: "./DBCore"),
        .package(path: "./Routers")


        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AppFlow",
            dependencies: ["Authenticate",
                           "Home",
                           "DBService",
                           "DBCore",
                           "MessageCenter",
                           "Routers"
                          ],
            resources: [
                .process("Resources")
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedLibrary("c++")
            ]
        ),
        .testTarget(
            name: "AppFlowTests",
            dependencies: [
                "AppFlow",
                .product(name: "AuthenticateMocks", package: "Authenticate"),
            ],
            resources: [
                .process("Resources")
            ],
            linkerSettings: [
//                .linkedLibrary("z"),
//                .linkedLibrary("c++")
            ]
        ),
    ]
)
