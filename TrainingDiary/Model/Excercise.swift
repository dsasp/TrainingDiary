//
//  Exercise.swift
//  SwiftTests
//
//  Created by Dieter on 28.11.25.
//

import Foundation

let exerciseVersion: Int = 1
let setVersion: Int = 1

// Exercises json file
let exercisesFile = "Exercises.json"
// Excercise icon name
let imageExercise = "figure.strengthtraining.traditional"

enum ExerciseCategory: Int, Codable {
    case gym
    case cardio
    case stretching
    case warmup
//    case running
//    case hiking
//    case cycling
//    case swimming
    var id: Self { self }
}

enum MuscleGroup: String, Codable {
    case chest      // Brust
    case shoulders  // Schulter
    case arms       // Arme
    case back       // Rücken
    case legs       // Beine
    case core       // Rumpf
    case body       // Ganzkörper
}
extension MuscleGroup {
    var displayName: String {
        switch self {
        case .back: return "Back"
        case .arms: return "Arms"
        case .chest: return "Chest"
        case .legs: return "Legs"
        case .shoulders: return "Shoulders"
        case .core: return "Core"
        case .body: return "Body"
        }
    }
}

enum ExcerciseCategoryIcon: String, Codable {
    case gym = "figure.strengthtraining.traditional"
    case cardio = "heart"
    case stetching = "figure.strengthtraining.functional"
    case warmup = "flame"
    case cooldown = "showflake"
//    case running = "figure.run"
//    case hiking = "figure.hiking"
//    case cycling = "figure.outdoor.cycle"
//    case swimming = "figure.pool.swim"
    
    var id: Self { self }
}

// Set within an excercise, used for exercise of category .gym
struct Set: Identifiable, Codable {
    var version: Int
    var id: UUID
    var weight: Double
    var reps: Int
    var notes: String
    var pause: Duration     // pause after set
    var isWarmup: Bool
    var isCoolDown: Bool    // for future use
    
    init(version: Int = setVersion, id: UUID = UUID(), weight: Double = 0, reps: Int = 1, notes: String = "", pause: Duration = .zero, isWarmup: Bool = false, isCoolDown: Bool = false) {
        self.version = version
        self.id = id
        self.weight = weight
        self.reps = reps
        self.notes = notes
        self.pause = pause
        self.isWarmup = isWarmup
        self.isCoolDown = isCoolDown
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
    var muscleGroups: [MuscleGroup] // muscle groups
  
    init(version: Int = exerciseVersion, id: UUID = UUID(), name: String = "", description: String = "", notes: String = "", device: String = "" , category: ExerciseCategory = .gym, icon: ExcerciseCategoryIcon = .gym ,image: String = "" , start: Date = Date.now, end: Date = Date.now, sets: [Set] = [], duration: Duration = .seconds(15*60), muscleGroups: [MuscleGroup] = []) {
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
        self.muscleGroups = muscleGroups
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
        case .stretching: return "Stretching"
        case .warmup: return "Warmup"
//        case .running: return "Running"
//        case .hiking: return "Hiking"
//        case .cycling: return "Cycling"
//        case .swimming: return "Swimming"
       
        }
    }

    var iconName: String {
        switch self {
        case .gym: return ExcerciseCategoryIcon.gym.rawValue
        case .cardio: return ExcerciseCategoryIcon.cardio.rawValue
        case .stretching: return ExcerciseCategoryIcon.stetching.rawValue
        case .warmup: return ExcerciseCategoryIcon.warmup.rawValue
//        case .running: return ExcerciseCategoryIcon.running.rawValue
//        case .hiking: return ExcerciseCategoryIcon.hiking.rawValue
//        case .cycling: return ExcerciseCategoryIcon.cycling.rawValue
//        case .swimming: return ExcerciseCategoryIcon.swimming.rawValue
        
        }
    }
}


