// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "YourFrameworkName",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "SedraCheck", targets: ["SedraCheck"])
    ],
    targets: [
        .target(
            name: "SedraCheck",
            path: "SedraCheck.xcframework"
        )
    ]
)
