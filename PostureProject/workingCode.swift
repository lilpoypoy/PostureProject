//
//  workingCode.swift
//  PostureProject
//
//  Created by Noah M on 3/20/25.
//

//import AVFoundation
//import Foundation
//import Vision
//import SwiftUI
//import TabularData
//
//class BodyLandmarks: ObservableObject {
//    @Published var landmarks: [CGPoint]? = nil
//    private let bodyPoseRequest = VNDetectHumanBodyPoseRequest()
//    
//    //create a dictionary to grab convert joint locations to compatible CGPoint format
//    //to calc necessary values for posture data
//    //VNHumanBodyPoseObservation.JointName is the type of key
//    // values are of type CGPoint
//    //empty dictionary writting as "[:]"
//    var landmarkDict: [VNHumanBodyPoseObservation.JointName: CGPoint] = [:]
//    //create instance to access CSVManager
//    private let csvManager = CSVManager()
//    
//    func processFrame(_ cgImage: CGImage) {
//        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
//        
//        do{
//            try requestHandler.perform([bodyPoseRequest])
//            
//            if let results = bodyPoseRequest.results {
//                handlePoseObservations(results)
//                
//                
//            }
//        } catch {
//            print("Error processing frame: \(error)")
//        }
//    }
//    
//    private func handlePoseObservations(_ observations: [VNHumanBodyPoseObservation]) {
//        guard let observation = observations.first else { return }
//        
//        //create a dictionary to grab convert joint locations to compatible CGPoint format
//        //to calc necessary values for posture data
//        //VNHumanBodyPoseObservation.JointName is the type of key
//        // values are of type CGPoint
//        //empty dictionary writting as "[:]"
//        var landmarkDict: [VNHumanBodyPoseObservation.JointName: CGPoint] = [:]
//        
//        do {
//            //face landmarks(eyes, nose, chin)
//            let facePoints = try observation.recognizedPoints(.face)
//            
//            //upper body landmarks (neck & shoulders)
//            let upperBodyPoints = try observation.recognizedPoints(.torso)
//            
//            //Define the target joints
//            let targetJoints: [VNHumanBodyPoseObservation.JointName] = [
//                .leftEye,
//                .nose,
//                .rightEye,
//                .neck,
//                .rightShoulder,
//                .leftShoulder
//            ]
//            
//            let points = targetJoints.compactMap { key -> (VNHumanBodyPoseObservation.JointName, CGPoint)? in
//                if let point = facePoints[key], point.confidence > 0.5 {
//                    print("\(key) with confidence: \(point.confidence)")
//                    landmarkDict[key] = CGPoint(x: point.location.x, y: 1 - point.location.y)
//                    return (key, CGPoint(x: point.location.x, y: 1 - point.location.y))
//                }
//                if let point = upperBodyPoints[key], point.confidence > 0.5 {
//                    print("\(key) with confidence: \(point.confidence)")
//                    landmarkDict[key] = CGPoint(x: point.location.x, y: 1 - point.location.y)
//                    return (key, CGPoint(x: point.location.x, y: 1 - point.location.y))
//                }
//                return nil
//            }
//            
//            //calculations for posture
//            if let leftEye = landmarkDict[.leftEye],
//               let nose = landmarkDict[.nose],
//               let rightEye = landmarkDict[.rightEye],
//               let neck = landmarkDict[.neck],
//               let rightShoulder = landmarkDict[.rightShoulder],
//               let leftShoulder = landmarkDict[.leftShoulder] {
//                
//                let headTilt = angle(p1: leftEye, p2: rightEye)
//                let headLean = displacement(p1: neck, p2: nose)
//                let headRotation = displacementX(p1: nose, p2: neck)
//                let shoulderTilt = angle(p1: leftShoulder, p2: rightShoulder)
//                //print("head rotate displacement: \(headRotation)")
//                print("head lean forward/backward: \(headLean)")
//                
//            }
//            
//            DispatchQueue.main.async {
//                self.landmarks = points.map { $0.1 }
//            }
//            
//        } catch {
//            print("Error handling pose observations: |(error)")
//        }
//    }
    
