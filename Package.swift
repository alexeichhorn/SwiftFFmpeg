// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let linkerSettings: [LinkerSetting]
let dependencies: [Package.Dependency]
let targetDependencies: [Target.Dependency]
#if os(Linux)
linkerSettings = [
    .linkedLibrary("avformat"),
    .linkedLibrary("avcodec"),
    .linkedLibrary("avutil")
]

dependencies = [
    .package(url: "https://github.com/alexeichhorn/FFmpegKit-Linux/", branch: "main")
]

targetDependencies = [
    .product(name: "FFmpeg", package: "ffmpegkit-linux")
]
#else
linkerSettings = []

dependencies = [
    .package(url: "https://github.com/tylerjonesio/ffmpeg-kit-spm/", from: "5.1.0")
]

targetDependencies = [
    .product(name: "FFmpeg", package: "ffmpeg-kit-spm")
]
#endif

let package = Package(
    name: "SwiftFFmpeg",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftFFmpeg",
            targets: ["SwiftFFmpeg"]),
    ],
    dependencies: dependencies,
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftFFmpeg",
            dependencies: targetDependencies,
            swiftSettings: [
              .enableExperimentalFeature("StrictConcurrency")
            ],
            linkerSettings: linkerSettings
        ),
        .testTarget(
            name: "SwiftFFmpegTests",
            dependencies: ["SwiftFFmpeg"]),
    ]
)
