// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ShioriPackage",
  platforms: [
    .iOS(.v18)
  ],
  products: [
    .library(
      name: "AppFeature",
      targets: ["AppFeature"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-dependencies", exact: "1.9.2"),
    .package(url: "https://github.com/realm/SwiftLint", exact: "0.59.1"),
  ],
  targets: [
    .target(
      name: "AboutFeature",
    ),
    .target(
      name: "AccessFeature",
    ),
    .target(
      name: "AppFeature",
    ),
    .target(
      name: "GreetingFeature",
    ),
    .target(
      name: "PhotoGalleryFeature",
    ),
    .target(
      name: "ProfileFeature",
    ),
    .testTarget(
      name: "ShioriPackageTests",
    ),
  ]
)
