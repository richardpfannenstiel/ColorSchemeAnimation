//
//  RectKey.swift
//
//
//  Created by Richard Pfannenstiel on 16.02.24.
//

import SwiftUI

struct RectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
