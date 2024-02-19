//
//  TransitionView.swift
//
//
//  Created by Richard Pfannenstiel on 18.02.24.
//

import SwiftUI

struct TransitionView: View {
    
    let old: UIImage
    let new: UIImage
    let animationStartingPoint: CGRect
    let animationDuration: TimeInterval
    
    @State private var maskAnimation: Bool = false
    
    var body: some View {
        ZStack {
            Image(uiImage: old)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.current?.bounds.width, height: UIScreen.current?.bounds.height)
            Image(uiImage: new)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.current?.bounds.width, height: UIScreen.current?.bounds.height)
                .mask(alignment: .topLeading) {
                    Circle()
                        .frame(width: animationStartingPoint.width * (maskAnimation ? 100 : 1), height: animationStartingPoint.height * (maskAnimation ? 100 : 1), alignment: .center)
                        .frame(width: animationStartingPoint.width, height: animationStartingPoint.height)
                        .offset(x: animationStartingPoint.minX, y: animationStartingPoint.minY)
                        .ignoresSafeArea()
                }
                .task {
                    guard !maskAnimation else { return }
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        maskAnimation = true
                    }
                }
        }.ignoresSafeArea()
    }
}
