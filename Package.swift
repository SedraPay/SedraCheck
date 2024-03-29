// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SedraCheck",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "SedraCheck",
            targets: ["SedraCheck"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "SedraCheck",
            url: "https://github.com/SedraPay/SedraCheck/releases/download/1.6.2/SedraCheck.xcframework.zip",
            checksum: "403a42a5ab30861d79761ba229d33b91e74b31d810844effc129f774a5ffddea"
        ),
    ]
)
