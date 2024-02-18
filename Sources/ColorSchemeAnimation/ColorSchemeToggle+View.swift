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
            .onTapGesture {
                ColorSchemeAnimation.changeColorScheme(to: requestedColorScheme, from: startingPoint, animationDuration: animationDuration)
            }
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
    func onTapChangeColorScheme(to scheme: CustomColorScheme, animationDuration: TimeInterval = 1) -> some View {
        self.modifier(ColorSchemeToggle(requestedColorScheme: scheme, animationDuration: animationDuration))
    }
}
