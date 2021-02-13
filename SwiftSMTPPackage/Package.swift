// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Catapult",
    products: [.library(
            name: "Catapult",
            targets: ["Catapult"]),
    ],
    dependencies: [.package(url: "https://github.com/Kitura/Swift-SMTP", .upToNextMinor(from: "5.1.0")),    // add the dependency
    ],
    targets: [
        .target(
            name: "Catapult",
            dependencies: ["SwiftSMTP"],
            path: "Sources"),                                                           // add targets
        .testTarget(                                                                                // note "SwiftSMTP" (NO HYPHEN)
            name: "CatapultTests",
            dependencies: ["SwiftSMTP"],
            path: "Tests"),
    ]
)
