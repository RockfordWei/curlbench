// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "curlbench",
    dependencies: [
        .package(url: "https://github.com/PerfectlySoft/Perfect-CURL.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "curlbench",
            dependencies: ["PerfectCURL"]),
    ]
)
