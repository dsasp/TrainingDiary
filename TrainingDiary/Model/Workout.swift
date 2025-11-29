//
//  Workout.swift
//  TrainingDiary
//
//  Created by Dieter on 29.11.25.
//

import SwiftUI
import Foundation

// Workout format version
let workoutVersion: Int = 1
// Workouts json file
let workoutsFile = "Workouts.json"
// Workout icon name
let imageWorkout = "calendar"

// workout
struct Workout: Identifiable, Codable {
    var version: Int
    var id: UUID
    var name: String
    var iconName: String            // system image name of icon
    var description: String
    var start: Date
    var end: Date
    var exercises: [Exercise]
    var isFavorite: Bool = false    // for future use
    var dataString: [String]        // for future use
    var dataInt: [Int]              // for future use
    
    init(version: Int = workoutVersion, id: UUID = UUID(), name: String = "", iconName: String = imageWorkout, description: String = "", start: Date = Date.now, end: Date = Date.now, excercises: [Exercise] = [], isFavorite: Bool = false, dataString: [String] = [], dataInt: [Int] = []) {
        self.version = version
        self.id = id
        self.name = name
        self.iconName = iconName
        self.description = description
        self.start = start
        self.end = end
        self.exercises = excercises
        self.isFavorite = isFavorite
        self.dataString = dataString
        self.dataInt = dataInt
    }
}
