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
    @State var Rotation:CGFloat = 0.0
    
    var body: some View {
        if #available(macOS 15.0, *) {
            GeometryReader { geometry in
                ZStack{
                    //displays image on UI
                    FrameView(image: model.frame)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                
                    //stack to display glowing green/red rim for posture
                    postureAnimation(rotation: Rotation, geometry: geometry, posture_eval: bodyLandmarks.postureEval)
                    
                    //landmarks
                    if let landmarks = bodyLandmarks.landmarks {
                        ForEach(landmarks, id: \.self) { points in
                            Circle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                                .position(x: (1 - points.x) * geometry.size.width, y: (points.y * geometry.size.height) )
                        }
                    } else {
                        Text("No landmarks detected. Please ensure full upper body is within frame")
                            .foregroundColor(.red)
                            .bold()
                    }
                }
//                .ignoresSafeArea()
                    
                .onAppear {
                    print("ContentView appeared.")
                    //telling bodyLandmarks class to get landmarks from the new frame
                    self.model.onFrameCaptured = { cgImage in
                        bodyLandmarks.processFrame(cgImage)
                    }
                    //rotating animation for postureAnimation
                    withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)){
                        Rotation = 360
                    }
                }
            }
        }
        else {
            //Fallback on earlier versions
        }
    }
}

//call the function in Zstack to animate posture
func postureAnimation(rotation: CGFloat, geometry: GeometryProxy, posture_eval: Double?) -> some View {
    var gradient: LinearGradient
    
    //checks for posture evaluation in bodyLandmarks
    if (posture_eval == 1.0){
        gradient = LinearGradient(colors: [.green, .cyan, .green], startPoint: .leading, endPoint: .trailing)
    }
    else{
        gradient = LinearGradient(colors: [.red, .orange, .red], startPoint: .leading, endPoint: .trailing)
    }
    
    return (
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(gradient)
            .rotationEffect(.degrees(rotation))
            .frame(width: geometry.size.width+200, height: geometry.size.height-100)
        //                        .aspectRatio(contentMode: .fill)
            .mask{
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(lineWidth: 7)
                    .frame(width: geometry.size.width-5, height: geometry.size.height-5)
            }
            .position(x: geometry.size.width/2, y: geometry.size.height/2)
        )
}

#Preview {
    ContentView()
        .aspectRatio(16/9, contentMode: .fit)
}
