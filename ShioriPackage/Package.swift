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
    .package(url: "https://github.com/onevcat/Kingfisher", exact: "8.5.0"),
    .package(url: "https://github.com/rechsteiner/Parchment", exact: "4.1.0"),
    .package(url: "https://github.com/pointfreeco/swift-tagged", exact: "0.10.0"),
  ],
  targets: [
    .target(
      name: "AboutFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "Utility",
      ]
    ),
    .target(
      name: "AccessFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "ErrorFeature",
        "Utility",
      ]
    ),
    .target(
      name: "AppFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "MainTabFeature",
        "PublicationEndFeature"
      ]
    ),
    .target(
      name: "ErrorFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "Utility",
      ]
    ),
    .target(
      name: "GreetingFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Kingfisher", package: "Kingfisher"),
        "ErrorFeature",
        "Utility",
      ]
    ),
    .target(
      name: "MainTabFeature",
      dependencies: [
        "AboutFeature",
        "AccessFeature",
        "GreetingFeature",
        "PhotoGalleryFeature",
        "ProfileFeature",
        "Utility",
      ]
    ),
    .target(
      name: "PhotoGalleryFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Kingfisher", package: "Kingfisher"),
        .product(name: "Tagged", package: "swift-tagged"),
        "ErrorFeature",
        "Utility",
      ]
    ),
    .target(
      name: "ProfileFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Kingfisher", package: "Kingfisher"),
        .product(name: "Parchment", package: "Parchment"),
        .product(name: "Tagged", package: "swift-tagged"),
        "ErrorFeature",
        "Utility",
      ]
    ),
    .target(
      name: "PublicationEndFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "Utility",
      ],
    ),
    .target(
      name: "Utility",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .testTarget(
      name: "ShioriPackageTests",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "AppFeature",
      ]
    )
  ]
)
