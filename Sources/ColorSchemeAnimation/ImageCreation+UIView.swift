//
//  ImageCreation+UIView.swift
//
//
//  Created by Richard Pfannenstiel on 18.02.24.
//

import UIKit

extension UIView {
    func image(_ size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            drawHierarchy(in: .init(origin: .zero, size: size), afterScreenUpdates: true)
        }
    }
}
