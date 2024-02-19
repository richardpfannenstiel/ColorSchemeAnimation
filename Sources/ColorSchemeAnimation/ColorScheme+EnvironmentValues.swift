//
//  ColorScheme+EnvironmentValues.swift
//
//
//  Created by Richard Pfannenstiel on 18.02.24.
//

import SwiftUI

public extension EnvironmentValues {
    
    /// The ``CustomColorScheme`` environment value.
    ///
    /// It will reflect the custom scheme set for the application and can be accessed within any view.
    /// SwiftUI will redraw views that depend on the environment value.
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
    var customColorScheme: CustomColorScheme {
        get { Storage.shared.currentColorScheme }
    }
}
