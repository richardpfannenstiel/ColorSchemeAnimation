//
//  ContentView.swift
//
//
//  Created by Richard Pfannenstiel on 19.02.24.
//

import SwiftUI
import ColorSchemeAnimation

struct ContentView: View {
    
    @Environment(\.customColorScheme) var colorScheme
    
    let colorSchemes: [CustomColorScheme] = [.system, .light, .dark]
    
    @State var animationDuration: TimeInterval = 1
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("You're using the \(colorScheme.rawValue) color scheme.")
                } header: {
                    Text("Color Scheme Display")
                }
                Section {
                    HStack(spacing: 20) {
                        ForEach(colorSchemes, id: \.self) { colorScheme in
                            Text(colorScheme.rawValue)
                                .frame(width: 100)
                                .padding(.vertical, 5)
                                .background(.secondary.opacity(0.3))
                                .cornerRadius(10)
                                .onTapChangeColorScheme(to: colorScheme)
                        }
                    }
                } header: {
                    Text("Distinct Buttons")
                }
                Section {
                    VStack {
                        Slider(value: $animationDuration, in: 0.5...10, step: 0.5)
                        Text("Animation Duration: \(animationDuration, specifier: "%.1f")s")
                    }
                    HStack {
                        Spacer()
                        Image(systemName: colorScheme == .dark ? "lightbulb.max.fill" : "lightbulb.slash.fill")
                        Text(colorScheme == .dark ? "Turn on the lights" : "Turn off the lights")
                            .padding(.vertical, 5)
                        Spacer()
                    }
                    .onTapChangeColorScheme(to: colorScheme == .dark ? .light : .dark, animationDuration: animationDuration)
                    .background(.secondary.opacity(0.3))
                    .cornerRadius(10)
                } header: {
                    Text("Animation Speed")
                }
            }.navigationTitle("Settings")
                .toolbar(content: {
                    Image(systemName: colorScheme == .dark ? "sun.max.fill" : "moon.fill")
                        .onTapChangeColorScheme(to: colorScheme == .dark ? .light : .dark)
                })
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme()
}
