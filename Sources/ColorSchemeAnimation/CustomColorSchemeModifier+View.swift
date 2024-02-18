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

extension View {
    public func preferredColorScheme() -> some View {
        self.modifier(CustomColorSchemeModifier())
    }
}
