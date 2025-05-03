//
//  FrameView.swift
//  PostureProject
//
//  Created by Noah M on 2/27/25.
//

import SwiftUI

struct FrameView: View {
    var image: CGImage?
    private let label = Text("frame")
    
    var body: some View {
        if let image = image {
            Image(image, scale: 1.0, orientation: .upMirrored, label: label)
                .resizable()
                .scaledToFit()
        } else {
            Color.black
        }
    }
}

#Preview {
    FrameView()
}
