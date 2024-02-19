//
//  Storage.swift
//
//
//  Created by Richard Pfannenstiel on 16.02.24.
//

import SwiftUI

class Storage: ObservableObject {
    
    static let REQUEST_PATH = "colorSchemeAnimation.colorSchemeRequest"
    static let SCHEME_PATH = "colorSchemeAnimation.colorScheme"
    
    static var shared = Storage()
    
    @AppStorage(REQUEST_PATH) var requestedColorScheme: CustomColorScheme = .DEFAULT
    @AppStorage(SCHEME_PATH) var currentColorScheme: CustomColorScheme = .DEFAULT
    
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
