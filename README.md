# Color Scheme Animation
This package provides a simple and easy implemenation of an application specific color scheme. The user may set a custom appearance for your application which can be light, dark or reflect the system's dark mode settings. Switching color scheme will be animated as shown in the example below.

<div align="center" width="100%">
  <img src="https://github.com/richardpfannenstiel/ColorSchemeAnimation/assets/57414694/cc6287bc-7b18-4fb6-bbe7-e309ebd4d931" width="25%"/>
</div>

## Installation
Use the [Swift Package Manager](https://github.com/apple/swift-package-manager) and follow the [tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) using the URL for this repository.

1. In Xcode, select `File` → `Add Package Dependencies...`.
2. Paste `https://github.com/richardpfannenstiel/ColorSchemeAnimation.git` into the search field.

Alternatively, you can add the following dependency to your `Package.swift` file:

```swift
.package(url: "https://github.com/richardpfannenstiel/ColorSchemeAnimation.git")
```
Afterwards, you may use the package functionality by importing it into any of your project's files.

```swift
import ColorSchemeAnimation
```

