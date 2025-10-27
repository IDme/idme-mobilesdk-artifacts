// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "IDmeSDK",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Consumers import "IDmeSDK" which resolves to the wrapper target
        // This automatically brings in all dependencies without consumers needing to declare them
        .library(
            name: "IDmeSDK",
            targets: ["IDmeSDKWrapper"]),
    ],
    dependencies: [
        // All dependencies that the SDK needs
        // Consumers don't need to add these - SPM resolves them automatically
        .package(url: "https://github.com/openid/AppAuth-iOS.git", from: "2.0.0"),
        .package(url: "https://github.com/auth0/JWTDecode.swift", from: "3.3.0"),
        .package(url: "https://github.com/Veriff/veriff-ios-spm", from: "8.3.0"),
        .package(url: "https://github.com/Veriff/veriff-nfc-ios-spm", from: "8.5.0"),
        .package(url: "https://github.com/krzyzanowskim/OpenSSL-Package.git", exact: "3.3.3001"),
        .package(url: "https://github.com/open-telemetry/opentelemetry-swift", from: "1.17.1"),
    ],
    targets: [
        // The actual binary XCFramework
        .binaryTarget(
            name: "IDmeSDK",
            url: "https://github.com/IDme/idme-mobilesdk-artifacts/releases/download/iOS-v0.0.20/IDmeSDK-v0.0.20.xcframework.zip",
            checksum: "b49e814192299061fd8cbcc1902f18cac65b52d16e3e031ced1ca7c5299b1d55"
        ),

        // Wrapper target that ties the binary with all dependencies
        // This is what consumers actually import (as "IDmeSDK")
        .target(
            name: "IDmeSDKWrapper",
            dependencies: [
                "IDmeSDK",
                .product(name: "AppAuth", package: "AppAuth-iOS"),
                .product(name: "AppAuthCore", package: "AppAuth-iOS"),
                .product(name: "JWTDecode", package: "jwtdecode.swift"),
                .product(name: "OpenTelemetryApi", package: "opentelemetry-swift"),
                .product(name: "OpenTelemetrySdk", package: "opentelemetry-swift"),
                .product(name: "OpenTelemetryProtocolExporter", package: "opentelemetry-swift"),
                .product(name: "OpenTelemetryProtocolExporterHTTP", package: "opentelemetry-swift"),
                .product(name: "OpenSSL", package: "OpenSSL-Package"),
                .product(name: "Veriff", package: "veriff-ios-spm"),
                .product(name: "VeriffNFC", package: "veriff-nfc-ios-spm"),
            ],
            path: "Sources/IDmeSDKWrapper"
        )
    ]
)
