// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "UserAuthApp",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        .package(name: "vapor", url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(name: "fluent", url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(name: "fluent-sqlite-driver", url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0"),
        .package(name: "leaf", url: "https://github.com/vapor/leaf.git", from: "4.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "Vapor", package: "vapor"),
            .product(name: "Leaf", package: "leaf"),
        ]),
        .target(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
