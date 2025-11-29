//
//  Globals.swift
//  TrainingDiary
//
//  Created by Dieter on 29.11.25.
//
import SwiftUI
import Foundation
import Combine
import os

let globLog = Logger(subsystem: logSubSystem,category: fileNameOf(#file))

class Globals: ObservableObject {
    
    // Globals singleton.
    static let shared = Globals()
    
    // Enforce Globals singleton by making init() private
    private init() {
        // use defaults
        globLog.notice("init(): globals instantiated")
    }
    
    
    // Global list of exercises, stored as .json file
    @Published var exerciseList: [Exercise] = {
        
        //   Try loading current version of Parcours3D, if this fails, try to load previous
        //   version to handle migration scenarios.
        globLog.notice("Try loading exercise data, format version=\(exerciseVersion)")
        if let eList:[Exercise] = loadFromAppSupportDir(exercisesFile) { // func return nil on failure
            
            if eList.count>0 {
                globLog.notice("Found \(eList.count) exercises, version=\(eList[0].version)")
            }
            return eList
            
        } else {
            // failed to load exercise data, retries or migration code would go here
            globLog.error("Failed to load exercise data")
            return[]
        }}()
}


