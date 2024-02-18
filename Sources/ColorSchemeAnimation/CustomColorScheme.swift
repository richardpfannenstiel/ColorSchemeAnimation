//
//  CustomColorScheme.swift
//
//
//  Created by Richard Pfannenstiel on 16.02.24.
//

import SwiftUI

/// The custom color schemes, corresponding to the explicit light, dark or system-wide set appearances.
///
/// You may receive the current color scheme by reading the ``CustomColorScheme`` environment value.
/// It will reflect the custom scheme set for the application.
/// The color scheme can be changed through the functions ``ColorSchemeAnimation/ColorSchemeAnimation/changeColorScheme(to:)``,
/// ``ColorSchemeAnimation/ColorSchemeAnimation/changeColorScheme(to:from:animationDuration:)-30tda`` or
/// ``ColorSchemeAnimation/ColorSchemeAnimation/changeColorScheme(to:from:animationDuration:)-1hc4k``.
/// SwiftUI will redraw  views that depend on the environment value.
/// In the following example, the view will automatically update its text if the custom color scheme is changed.
///
/// ```swift
/// @Environment(\.customColorScheme) var colorScheme
///
/// var body: some View {
///     switch colorScheme {
///     case .system:
///         Text("System")
///     case .light:
///         Text("Light")
///     case .dark:
///         Text("Dark")
///     }
/// }
/// ```
/// Mind you'll need to set the custom app appearance for a particular view hierarchy using the ``SwiftUI/View/preferredColorScheme()`` view modifier.
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

public enum CustomColorScheme: String {
    
    static let DEFAULT = CustomColorScheme.system
    
    case system = "system"
    case light = "light"
    case dark = "dark"
    
    var scheme: ColorScheme? {
        switch self {
            case .system: nil
            case .light: .light
            case .dark: .dark
        }
    }
}
