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
      targets: ["AppFeature",
                "MainTabFeature",
                "GreetingFeature",
                "ProfileFeature",
                "AccessFeature",
                "PhotoGalleryFeature",
                "AboutFeature"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.20.2"),
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
      dependencies: [
        "MainTabFeature"
      ]
    ),
    .target(
      name: "GreetingFeature",
    ),
    .target(
      name: "MainTabFeature",
      dependencies: [
        "AboutFeature",
        "AccessFeature",
        "GreetingFeature",
        "PhotoGalleryFeature",
        "ProfileFeature",
      ]
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
