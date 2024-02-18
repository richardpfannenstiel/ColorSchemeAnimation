//
//  PositionCapture+View.swift
//
//
//  Created by Richard Pfannenstiel on 18.02.24.
//

import SwiftUI

public extension View {
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
