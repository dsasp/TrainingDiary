//
//  Exercise.swift
//  SwiftTests
//
//  Created by Dieter on 28.11.25.
//

import Foundation

let exerciseVersion: Int = 1
let setVersion: Int = 1

enum ExerciseCategory: Int, Codable {
    case gym
    case cardio
    case warmup
    case running
    case hiking
    case cycling
    case stetching
    case swimming
    var id: Self { self }
}

enum ExcerciseCategoryIcon: String, Codable {
    case gym = "figure.strengthtraining.traditional"
    case cardio = "heart"
    case running = "figure.run"
    case hiking = "figure.hiking"
    case cycling = "figure.outdoor.cycle"
    case stetching = "figure.strengthtraining.functional"
    case swimming = "figure.pool.swim"
    case warmup = "flame"
    var id: Self { self }
}

// Set within an excercise, used for exercise of category .gym
struct Set: Identifiable, Codable {
    var version: Int
    var id: UUID
    var weight: Double
    var reps: Int
    var notes: String
    var isWarmup: Bool
    
    init(version: Int = setVersion, id: UUID = UUID(), weight: Double = 0, reps: Int = 1, notes: String = "", isWarmup: Bool = false) {
        self.version = version
        self.id = id
        self.weight = weight
        self.reps = reps
        self.notes = notes
        self.isWarmup = isWarmup
    }
}


/// Training Exercise
struct Exercise: Identifiable, Codable {
    var version: Int                // exercise format version
    var id: UUID                    // unique id
    var name: String                // name
    var description: String         // description
    var notes: String               // notes/remarks
    var device: String              // device used for exercise
    var category: ExerciseCategory  // category
    var icon: ExcerciseCategoryIcon // icon
    var image: String               // image
    var start: Date                 // actual exercise start time
    var end: Date                   // actual exercise end time
    var sets: [Set]                 // sets in excercise
    var duration: Duration          // planned duration, applicable to some categories like .warmup, .running, ...
  
    init(version: Int = exerciseVersion, id: UUID = UUID(), name: String = "", description: String = "", notes: String = "", device: String = "" , category: ExerciseCategory = .gym, icon: ExcerciseCategoryIcon = .gym ,image: String = "" , start: Date = Date.now, end: Date = Date.now, sets: [Set] = [], duration: Duration = .seconds(15*60)) {
        self.version = version
        self.id = id
        self.name = name
        self.description = description
        self.notes = notes
        self.device = device
        self.category = category
        self.icon = icon
        self.image = image
        self.start = start
        self.end = end
        self.sets = sets
        self.duration = duration
    }
    
    mutating func startExcercise() {
        self.start = Date.now
    }
    
    mutating func endExcercise() {
        self.end = Date.now
    }
}

extension ExerciseCategory: CaseIterable {}

extension ExerciseCategory {
    var displayName: String {
        switch self {
        case .gym: return "Gym"
        case .cardio: return "Cardio"
        case .running: return "Running"
        case .hiking: return "Hiking"
        case .cycling: return "Cycling"
        case .stetching: return "Stretching"
        case .swimming: return "Swimming"
        case .warmup: return "Warmup"
        }
    }

    var iconName: String {
        switch self {
        case .gym: return ExcerciseCategoryIcon.gym.rawValue
        case .cardio: return ExcerciseCategoryIcon.cardio.rawValue
        case .running: return ExcerciseCategoryIcon.running.rawValue
        case .hiking: return ExcerciseCategoryIcon.hiking.rawValue
        case .cycling: return ExcerciseCategoryIcon.cycling.rawValue
        case .stetching: return ExcerciseCategoryIcon.stetching.rawValue
        case .swimming: return ExcerciseCategoryIcon.swimming.rawValue
        case .warmup: return ExcerciseCategoryIcon.warmup.rawValue
        }
    }
}
