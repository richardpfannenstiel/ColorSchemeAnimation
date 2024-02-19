//
//  ImageCreation+UIView.swift
//
//
//  Created by Richard Pfannenstiel on 18.02.24.
//

import UIKit

extension UIView {
    
    /// Captures the contents of a ``UIKit/UIView``  in a ``UIKit/UIImage``.
    ///
    /// - Parameter size: The preferred size of the requested image.
    /// - Returns: A screenshot of the view.
    func image(_ size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            drawHierarchy(in: .init(origin: .zero, size: size), afterScreenUpdates: true)
        }
    }
}
