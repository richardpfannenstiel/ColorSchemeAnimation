//
//  ExampleView.swift
//
//
//  Created by Richard Pfannenstiel on 18.02.24.
//

import SwiftUI

struct ExampleView: View {
    
    @Environment(\.customColorScheme) var colorScheme
    
    var body: some View {
        VStack {
            switch colorScheme {
            case .system:
                Text("System")
            case .light:
                Text("Light")
            case .dark:
                Text("Dark")
            }
            HStack(spacing: 20) {
                Text("System")
                    .onTapChangeColorScheme(to: .system)
                Text("Light")
                    .onTapChangeColorScheme(to: .light)
                Text("Dark")
                    .onTapChangeColorScheme(to: .dark)
            }.preferredColorScheme()
        }
    }
}

#Preview {
    ExampleView()
}
