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
    
    // Global list of exercises, persistemt in .json file
    @Published var exerciseList: [Exercise] = {
        globLog.notice("Try loading exercises, format version=\(exerciseVersion)")
        if let eList:[Exercise] = loadFromAppSupportDir(exercisesFile) { // func return nil on failure
            
            if eList.count>0 {
                globLog.notice("Found \(eList.count) exercises, version=\(eList[0].version)")
            }
            return eList
            
        } else {
            // failed to load exercise data, retries or migration code would go here
            globLog.error("Failed loading exercises")
            return[]
        }}()
    
    // Global list of workouts, persistemt in .json file
    @Published var workoutList: [Workout] = {
        globLog.notice("Try loading workouts, format version=\(workoutVersion)")
        if let wList:[Workout] = loadFromAppSupportDir(workoutsFile) { // func return nil on failure
            
            if wList.count>0 {
                globLog.notice("Found \(wList.count) workouts, version=\(wList[0].version)")
            }
            return wList
            
        } else {
            // failed to load workouts, retries or migration code would go here
            globLog.error("Failed loading workouts")
            return[]
        }}()
}


