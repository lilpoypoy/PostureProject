//
//  writeCSV.swift
//  PostureProject
//
//  Created by Noah M on 3/19/25.

import Foundation

class CSVManager {
    private let fileName = "posture_data.csv"
    
    func getFilePath() -> URL {
        let document = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) .first!
        return document.appendingPathComponent(fileName)
    }
    
    func writeToCSV(headTilt: Double, headLean: Double, headRotation: Double, shoulderTilt: Double) {
        let fileURL = getFilePath()
        let heading = "Head Tilt,Head Lean,Head Rotation,Shoulder Tilt\n"
        let newRow = "\(headTilt),\(headLean),\(headRotation),\(shoulderTilt)\n"
        
        do {
            //if the file is already created
            //access it and append a new row
            if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
                fileHandle.seekToEndOfFile()
                if let data = newRow.data(using: .utf8) {
                    fileHandle.write(data)
                }
                fileHandle.closeFile()
            } else {
                //if file is not created yet, then create and append the first row
                try heading.write(to: fileURL, atomically: true, encoding: .utf8)
            }
            print("Data written to CSV: \(newRow)")
        } catch{
            print("Error writing to CSV: \(error)")
        }
    }
    
    func readCSV() -> [[String]] {
        let fileURL = getFilePath()
        do {
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            let rows = content.components(separatedBy: "\n").map { $0.components(separatedBy: ",") }
            return rows
        } catch {
            print("Error reading CSV: \(error)")
            return []
        }
    }
}
