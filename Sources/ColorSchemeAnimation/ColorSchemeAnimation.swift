//
//  ColorSchemeAnimation.swift
//
//
//  Created by Richard Pfannenstiel on 18.02.24.
//

import SwiftUI

public class ColorSchemeAnimation {
    
    /// Changes the color scheme of the application.
    ///
    /// - Parameter to: The new ``CustomColorScheme`` the application should...
    ///
    ///
    /// > Note: Test.
    
    @MainActor
    public static func changeColorScheme(to scheme: CustomColorScheme) {
        Storage.shared.requestColorSchemeChange(to: scheme)
        Storage.shared.updateColorScheme()
    }
    
    @MainActor
    public static func changeColorScheme(to scheme: CustomColorScheme, from startingPoint: CGRect, animationDuration: TimeInterval = 1) {
        Storage.shared.requestColorSchemeChange(to: scheme)
        
        Task {
            if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow }) {
                let imageView = UIImageView()
                imageView.frame = window.frame
                imageView.image = window.rootViewController?.view.image(window.frame.size)
                imageView.contentMode = .scaleAspectFit
                window.addSubview(imageView)
                
                if let rootView = window.rootViewController?.view {
                    let frameSize = rootView.frame.size
                    let previousImage = rootView.image(frameSize)
                    Storage.shared.updateColorScheme()
                    try await Task.sleep(for: .milliseconds(10))
                    let currentImage = rootView.image(frameSize)
                    try await Task.sleep(for: .milliseconds(10))
                    imageView.removeFromSuperview()
                    
                    let controller = UIHostingController(
                        rootView: TransitionView(previousImage: previousImage, currentImage: currentImage, animationStartingPoint: startingPoint, animationDuration: animationDuration))
                    let transitionView = controller.view!
                    transitionView.frame = window.frame
                    transitionView.contentMode = .scaleAspectFit
                    window.addSubview(transitionView)
                    
                    try await Task.sleep(for: .seconds(animationDuration))
                    transitionView.removeFromSuperview()
                }
            }
        }
    }
    
    @MainActor
    public static func changeColorScheme(to scheme: CustomColorScheme, from alignment: Alignment = .topTrailing, animationDuration: TimeInterval = 1) {
        guard let screen = UIScreen.current?.bounds else {
            return
        }
        
        var origin: CGPoint = .zero
        
        switch alignment.horizontal {
        case .leading:
            origin = CGPoint(x: screen.minX, y: origin.y)
        case .center:
            origin = CGPoint(x: screen.midX, y: origin.y)
        case .trailing:
            origin = CGPoint(x: screen.maxX, y: origin.y)
        default:
            origin = CGPoint(x: screen.minX, y: origin.y)
        }
        
        switch alignment.vertical {
        case .top:
            origin = CGPoint(x: origin.x, y: screen.minY)
        case .center:
            origin = CGPoint(x: origin.x, y: screen.midY)
        case .bottom:
            origin = CGPoint(x: origin.x, y: screen.maxY)
        default:
            origin = CGPoint(x: origin.x, y: screen.midY)
        }
        
        let startingPoint: CGRect = CGRect(origin: origin, size: CGSize(width: 20, height: 20))
        changeColorScheme(to: scheme, from: startingPoint, animationDuration: animationDuration)
    }
}
