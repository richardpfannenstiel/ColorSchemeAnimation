//
//  PositionCapture+View.swift
//
//
//  Created by Richard Pfannenstiel on 18.02.24.
//

import SwiftUI

public extension View {

    /// Captures the dimension and position of the view on the screen.
    /// The provided closure will be supplied with the corresponding rectangle.
    /// - Parameter position: Intended to capture the view's dimensions.
    ///
    /// The following shows an example how the view modifier may be used to capture the position of
    /// a button which should act as the starting position for the color scheme changing animation.
    /// ```swift
    /// @State var animationPosition: CGRect = .zero
    ///
    /// var body: some View {
    ///     Button(action: {
    ///         ColorSchemeAnimation.changeColorScheme(to: .dark, from: animationPosition)
    ///     }) {
    ///         Text("Dark Appearance")
    ///     }.capturePosition { position in
    ///         animationPosition = position
    ///     }.preferredColorScheme()
    /// }
    /// ```
    func capturePosition(position: @escaping (CGRect) -> ()) -> some View {
        self.overlay(
            GeometryReader(content: { geometry in
                let rect = geometry.frame(in: .global)
                
                Color.clear
                    .preference(key: RectKey.self, value: rect)
                    .onPreferenceChange(RectKey.self, perform: { rect in
                        position(rect)
                    })
            })
        )
    }
}
