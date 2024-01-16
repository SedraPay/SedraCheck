// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "SedraCheck",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "SedraCheck",
            targets: ["SedraCheck"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "SedraCheck",
            url: "https://github.com/SedraPay/SedraCheck/blob/main/SedraCheck.xcframework.zip",
            checksum: "403a42a5ab30861d79761ba229d33b91e74b31d810844effc129f774a5ffddea")
        ),
    ]
)
