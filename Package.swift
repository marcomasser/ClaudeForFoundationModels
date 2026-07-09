// Copyright 2026 Anthropic PBC
// SPDX-License-Identifier: Apache-2.0

// swift-tools-version: 6.2
import PackageDescription

let package = Package(
  name: "ClaudeForFoundationModels",
  // Foundation Models supports server-side language models starting with OS 27.
  // This package defines support for lower OS versions so it can be depended
  // upon by projects that have lower deployment targets than OS 27.
  platforms: [
    .iOS(.v18), .macOS(.v15), .visionOS(.v2), .watchOS(.v11),
  ],
  products: [
    .library(name: "ClaudeForFoundationModels", targets: ["ClaudeForFoundationModels"])
  ],
  targets: [
    // Internal Messages API client. No FoundationModels dependency.
    .target(name: "ClaudeAPI"),

    // FoundationModels ↔ Messages API bridge.
    .target(
      name: "ClaudeForFoundationModels",
      dependencies: ["ClaudeAPI"]
    ),

    // Runnable usage example (`swift run ClaudeExample`). Deliberately not a
    // product — it exists to document the SDK, not to be depended on.
    .executableTarget(
      name: "ClaudeExample",
      dependencies: ["ClaudeForFoundationModels"],
      path: "Examples/ClaudeExample"
    ),

    .testTarget(
      name: "ClaudeAPITests",
      dependencies: ["ClaudeAPI"]
    ),
    .testTarget(
      name: "ClaudeForFoundationModelsTests",
      dependencies: ["ClaudeForFoundationModels"]
    ),
  ]
)
