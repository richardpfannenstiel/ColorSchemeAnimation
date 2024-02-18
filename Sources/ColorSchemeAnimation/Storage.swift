//
//  Storage.swift
//
//
//  Created by Richard Pfannenstiel on 16.02.24.
//

import SwiftUI

class Storage: ObservableObject {
    
    static var shared = Storage()
    
    @AppStorage("colorSchemeRequest") var requestedColorScheme: CustomColorScheme = .DEFAULT
    @AppStorage("colorScheme") var currentColorScheme: CustomColorScheme = .DEFAULT
    
    var colorScheme: ColorScheme? {
        currentColorScheme.scheme
    }
    
    func requestColorSchemeChange(to scheme: CustomColorScheme) {
        requestedColorScheme = scheme
    }
    
    func updateColorScheme() {
        currentColorScheme = requestedColorScheme
    }
    
}
