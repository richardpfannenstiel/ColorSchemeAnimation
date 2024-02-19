//
//  ColorSchemeToggle+View.swift
//
//
//  Created by Richard Pfannenstiel on 16.02.24.
//

import SwiftUI

private struct ColorSchemeToggle: ViewModifier {
    
    fileprivate let requestedColorScheme: CustomColorScheme
    fileprivate let animationDuration: TimeInterval
    @State private var startingPoint: CGRect = .zero
    
    func body(content: Content) -> some View {
        content
            // Update the color scheme as the user performs the tap gesture.
            .onTapGesture {
                ColorSchemeAnimation.changeColorScheme(to: requestedColorScheme, from: startingPoint, animationDuration: animationDuration)
            }
            // Capture the view position.
            .overlay(
                GeometryReader(content: { geometry in
                    let startingPoint = geometry.frame(in: .global)
                    
                    Color.clear
                        .preference(key: RectKey.self, value: startingPoint)
                        .onPreferenceChange(RectKey.self, perform: { startingPoint in
                            self.startingPoint = startingPoint
                        })
                })
            )
    }
}

public extension View {
    
    /// Changes the color scheme of the application when the view recognizes a tap gesture.
    /// Updating the scheme will automatically trigger an animation originating from the user's tap.
    /// - Parameters:
    ///   - scheme: The new ``CustomColorScheme`` the application should use.
    ///   - animationDuration: The duration for the color scheme changing animation to complete.
    ///
    /// ```swift
    /// var body: some View {
    ///     VStack {
    ///         Text("Light")
    ///             .onTapChangeColorScheme(to: .light)
    ///         Text("Dark")
    ///             .onTapChangeColorScheme(to: .dark)
    ///     }
    /// }
    /// ```
    func onTapChangeColorScheme(to scheme: CustomColorScheme, animationDuration: TimeInterval = 1) -> some View {
        self.modifier(ColorSchemeToggle(requestedColorScheme: scheme, animationDuration: animationDuration))
    }
}
