//
//  CurrentUIScreen+UIWindow.swift
//
//
//  Created by Richard Pfannenstiel on 18.02.24.
//

import SwiftUI

extension UIWindow {
    
    /// Provides static access to the device's current user interface window.
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}

extension UIScreen {
    
    /// Provides static access to the device's main interface screen including its dimensions.
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
