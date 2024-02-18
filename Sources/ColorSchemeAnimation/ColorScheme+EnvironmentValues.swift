//
//  ColorScheme+EnvironmentValues.swift
//
//
//  Created by Richard Pfannenstiel on 18.02.24.
//

import SwiftUI

extension EnvironmentValues {
  public var customColorScheme: CustomColorScheme {
      get { Storage.shared.currentColorScheme }
  }
}
