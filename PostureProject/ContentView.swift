//
//  ContentView.swift
//  PostureProject
//
//  Created by Noah M on 2/27/25.
//

import SwiftUI
import AVKit


struct ContentView: View {
    @StateObject var model = FrameHandler()
    @StateObject var bodyLandmarks = BodyLandmarks()
    @State private var landmarks: [CGPoint] = []
    
    var body: some View {
        if #available(macOS 15.0, *) {
            GeometryReader { geometry in
                ZStack{
                    //camera frame
                    FrameView(image: model.frame)
                        .ignoresSafeArea()
                    
                    //landmarks
                    if let landmarks = bodyLandmarks.landmarks {
                        ForEach(landmarks, id: \.self) { points in
                            Circle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                                .position(x: (1 - points.x) * geometry.size.width, y: (points.y * geometry.size.height) )
                        }
                    } else {
                        Text("No landmarks detected.")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .onAppear {
                    print("ContentView appeared.")
                    self.model.onFrameCaptured = { cgImage in
                        bodyLandmarks.processFrame(cgImage)
                    }
                }
            }
        }
        else {
            //Fallback on earlier versions
        }
    }
}

#Preview {
    ContentView()
}
