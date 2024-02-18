//
//  SwiftUIView.swift
//
//
//  Created by Richard Pfannenstiel on 16.02.24.
//

import SwiftUI

struct TestView: View {
    
    @State var tabSelection = 0
    @State private var selectedTheme = CustomColorScheme.system
    let themes: [CustomColorScheme] = [.system, .light, .dark]
    @Environment(\.customColorScheme) var colorScheme
    
    @State var startingPoint: CGRect = .zero
    
    var body: some View {
        TabView(selection: $tabSelection) {
            NavigationStack {
                VStack {
                    Text(colorScheme.rawValue)
                    HStack(spacing: 20) {
                        Text("System")
                            .onTabChangeColorScheme(to: .system)
                            .capturePosition { position in
                                startingPoint = position
                            }
                        Text("Light")
                            .onTabChangeColorScheme(to: .light)
                        Text("Dark")
                            .onTabChangeColorScheme(to: .dark)
                    }.padding(.vertical)
                    Picker("Appearance", selection: $selectedTheme) {
                        ForEach(themes, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selectedTheme) { oldValue, newValue in
                        ColorSchemeAnimation.changeColorScheme(to: newValue)
                    }
                }.navigationTitle("Home")
                    .toolbar(content: {
                        Image(systemName: colorScheme == .dark ? "sun.max.fill" : "moon.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .onTabChangeColorScheme(to: colorScheme == .dark ? .light : .dark)
                    })
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            NavigationStack {
                Text("Hallo")
                    .navigationTitle("Settings")
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }.preferredColorScheme()
    }
}

#Preview {
    TestView()
}
