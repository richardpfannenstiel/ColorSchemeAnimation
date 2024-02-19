//
//  ColorSchemeAnimation.swift
//
//
//  Created by Richard Pfannenstiel on 18.02.24.
//

import SwiftUI

public class ColorSchemeAnimation {
    
    /// Changes the color scheme of the application **without** an animation.
    ///
    /// - Parameter scheme: The new ``CustomColorScheme`` the application should use.
    ///
    /// To see the effect of changing the color scheme, you need to set the custom app appearance for a particular view hierarchy
    /// using the ``SwiftUI/View/preferredColorScheme()`` view modifier.
    /// ```swift
    /// @main
    /// struct MyApp: App {
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             AppView()
    ///                 .preferredColorScheme()
    ///         }
    ///     }
    /// }
    /// ```
    @MainActor
    public static func changeColorScheme(to scheme: CustomColorScheme) {
        Storage.shared.requestColorSchemeChange(to: scheme)
        Storage.shared.updateColorScheme()
    }
    
    /// Changes the color scheme of the application **with** an animation initiated from a provided starting point.
    ///
    /// - Parameters:
    ///   - scheme: The new ``CustomColorScheme`` the application should use.
    ///   - startingPoint: The position and dimension of the starting point for the scheme changing animation.
    ///   - animationDuration: The duration for the color scheme changing animation to complete.
    ///
    /// To see the effect of changing the color scheme, you need to set the custom app appearance for a particular view hierarchy
    /// using the ``SwiftUI/View/preferredColorScheme()`` view modifier.
    /// ```swift
    /// @main
    /// struct MyApp: App {
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             AppView()
    ///                 .preferredColorScheme()
    ///         }
    ///     }
    /// }
    /// ```
    @MainActor
    public static func changeColorScheme(to scheme: CustomColorScheme, from startingPoint: CGRect, animationDuration: TimeInterval = 1) {
        Storage.shared.requestColorSchemeChange(to: scheme)
        
        Task {
            if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow }) {
                // Create dummy image view to hide the instant change of the color scheme until the animation is complete.
                let imageView = UIImageView()
                imageView.frame = window.frame
                imageView.image = window.rootViewController?.view.image(window.frame.size)
                imageView.contentMode = .scaleAspectFit
                window.addSubview(imageView)
                
                if let rootView = window.rootViewController?.view {
                    let frameSize = rootView.frame.size
                    
                    // Capture current user interface prior to the color scheme change.
                    let oldViewImage = rootView.image(frameSize)
                    
                    // Change the color scheme and wait for the UI to update.
                    Storage.shared.updateColorScheme()
                    try await Task.sleep(for: .milliseconds(10))
                    
                    // Capture user interface after the color scheme change.
                    let newViewImage = rootView.image(frameSize)
                    try await Task.sleep(for: .milliseconds(10))
                    imageView.removeFromSuperview()
                    
                    // Instantiate the color scheme transition animation view and add it on top of the root view.
                    let controller = UIHostingController(
                        rootView: TransitionView(old: oldViewImage, new: newViewImage, animationStartingPoint: startingPoint, animationDuration: animationDuration))
                    let transitionView = controller.view!
                    transitionView.frame = window.frame
                    transitionView.contentMode = .scaleAspectFit
                    window.addSubview(transitionView)
                    
                    // Remove the transition view as soon as the animation has been completed.
                    try await Task.sleep(for: .seconds(animationDuration))
                    transitionView.removeFromSuperview()
                }
            }
        }
    }
    
    /// Changes the color scheme of the application **with** an animation initiated from a provided two-dimensional screen alignment.
    ///
    /// - Parameters:
    ///   - scheme: The new ``CustomColorScheme`` the application should use.
    ///   - startingPoint: The screen alignment to be used as a starting point for the scheme changing animation.
    ///   - animationDuration: The duration for the color scheme changing animation to complete.
    ///
    /// To see the effect of changing the color scheme, you need to set the custom app appearance for a particular view hierarchy
    /// using the ``SwiftUI/View/preferredColorScheme()`` view modifier.
    /// ```swift
    /// @main
    /// struct MyApp: App {
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             AppView()
    ///                 .preferredColorScheme()
    ///         }
    ///     }
    /// }
    /// ```
    @MainActor
    public static func changeColorScheme(to scheme: CustomColorScheme, from alignment: Alignment = .topTrailing, animationDuration: TimeInterval = 1) {
        guard let screen = UIScreen.current?.bounds else {
            return
        }
        
        // Create animation origin depending on the provided alignment.
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
