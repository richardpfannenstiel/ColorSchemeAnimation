//
//  ColorScheme+EnvironmentValues.swift
//
//
//  Created by Richard Pfannenstiel on 18.02.24.
//

import SwiftUI

public extension EnvironmentValues {
    var customColorScheme: CustomColorScheme {
        get { Storage.shared.currentColorScheme }
    }
}
