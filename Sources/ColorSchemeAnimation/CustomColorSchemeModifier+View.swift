//
//  File.swift
//  
//
//  Created by Richard Pfannenstiel on 16.02.24.
//

import SwiftUI

private struct CustomColorSchemeModifier: ViewModifier {
    
    @ObservedObject private var storage = Storage.shared
    
    func body(content: Content) -> some View {
        content.preferredColorScheme(storage.colorScheme)
    }
}

public extension View {
    
    /// Enables over-writting the system's dark mode settings with the ``CustomColorScheme`` set for the application.
    ///
    /// The custom app appearance for a particular view hierarchy is set with this view modifier.
    /// ```swift
    /// @main
    /// struct MyApp: App {
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             AppView()
    ///                 .preferredColorScheme()
    ///         }
    ///     }
    /// }
    /// ```
    /// The color scheme can be changed through the functions ``ColorSchemeAnimation/ColorSchemeAnimation/changeColorScheme(to:)``,
    /// ``ColorSchemeAnimation/ColorSchemeAnimation/changeColorScheme(to:from:animationDuration:)-30tda`` or
    /// ``ColorSchemeAnimation/ColorSchemeAnimation/changeColorScheme(to:from:animationDuration:)-1hc4k``.
    /// ```swift
    /// @Environment(\.customColorScheme) var colorScheme
    ///
    /// var body: some View {
    ///     Button(action: {
    ///         ColorSchemeAnimation.changeColorScheme(to: .dark, from: .bottom)
    ///     }) {
    ///         Text("Dark Appearance")
    ///     }
    /// }
    /// ```
    func preferredColorScheme() -> some View {
        self.modifier(CustomColorSchemeModifier())
    }
}
