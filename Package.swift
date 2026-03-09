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
        .package(url: "https://github.com/Veriff/veriff-ios-spm", from: "9.0.0"),
        .package(url: "https://github.com/Veriff/veriff-nfc-ios-spm", from: "9.0.0"),
        .package(url: "https://github.com/krzyzanowskim/OpenSSL-Package.git", exact: "3.3.3001"),
        .package(url: "https://github.com/open-telemetry/opentelemetry-swift", from: "1.17.1"),
        .package(url: "https://github.com/iProov/ios-spm.git", from: "13.0.0"),
    ],
    targets: [
        // The actual binary XCFramework
        .binaryTarget(
            name: "IDmeSDK",
            url: "https://github.com/IDme/idme-mobilesdk-artifacts/releases/download/iOS-v0.9.0/IDmeSDK-v0.9.0.xcframework.zip",
            checksum: "811afa3d082698aef0fa9a0df2ce95900a8bca066ecdcf8574293bf5ef4235ae"
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
                .product(name: "iProov", package: "ios-spm"),
            ],
            path: "Sources/IDmeSDKWrapper"
        )
    ]
)
