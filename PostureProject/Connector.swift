//
//  Connector.swift
//  PostureProject
//
//  Created by Noah M on 2/27/25.
//

import Foundation
import CoreGraphics
import Vision
import AVFoundation

class Connector {
    
    let frameHandler = FrameHandler()
    let bodyLandmarks = BodyLandmarks()
    
    init() {
        frameHandler.onFrameCaptured = { cgImage in
            self.bodyLandmarks.processFrame(cgImage)
        }
    }
}


