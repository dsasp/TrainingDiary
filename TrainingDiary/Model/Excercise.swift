//
//  Exercise.swift
//  SwiftTests
//
//  Created by Dieter on 28.11.25.
//

import Foundation
import os.log


let exLog = Logger(subsystem: logSubSystem,category: fileNameOf(#file))
let globals = Globals.shared

let exerciseVersion: Int = 1
let setVersion: Int = 1

// Exercises json file
let exercisesFile = "Exercises.json"
// Excercise icon name
let imageExercise = "figure.strengthtraining.traditional"


enum ExerciseCategory: String, Codable {
    case gym            // strenght training
    case cardio         // cardio and endurance training
    case stretching
    case warmup
    case cooldown
    var id: Self { self }
}

//enum ExcerciseCategoryIcon: String, Codable {
//    case gym = "figure.strengthtraining.traditional"
//    case cardio = "heart"
//    case stetching = "figure.strengthtraining.functional"
//    case warmup = "flame"
//    case cooldown = "showflake"
//    var id: Self { self }
//}

extension ExerciseCategory {  // get display name for exercise
    var displayName: String {
        switch self {
        case .gym: return "Gym"
        case .cardio: return "Cardio"
        case .stretching: return "Stretching"
        case .warmup: return "Warmup"
        case .cooldown: return "Cooldown"
        }
    }
}

extension ExerciseCategory {  // get name of icon for excercise
    var iconName: String {
        switch self {
        case .gym: return "figure.strengthtraining.traditional"
        case .cardio: return "heart"
        case .stretching: return "figure.strengthtraining.functional"
        case .warmup: return "flame"
        case .cooldown: return "snowflake"
        }
    }
}

extension ExerciseCategory: CaseIterable {}

enum MuscleGroup: String, Codable {
    case chest      // Brust
    case shoulders  // Schulter
    case arms       // Arme
    case back       // Rücken
    case abdominal  // Bauch
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
        case .abdominal: return "Abdominal"
        }
    }
}

extension MuscleGroup: CaseIterable {}

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
    var isCompleted: Bool
    
    init(version: Int = setVersion, id: UUID = UUID(), weight: Double = 0, reps: Int = 1, notes: String = "", pause: Duration = .zero, isWarmup: Bool = false, isCoolDown: Bool = false, isCompleted: Bool = false) {
        self.version = version
        self.id = id
        self.weight = weight
        self.reps = reps
        self.notes = notes
        self.pause = pause
        self.isWarmup = isWarmup
        self.isCoolDown = isCoolDown
        self.isCompleted = isCompleted
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
    var image: String               // image, not used
    var start: Date                 // actual exercise start time
    var end: Date                   // actual exercise end time
    var sets: [Set]                 // sets in excercise
    var duration: Duration          // planned duration, applicable to some categories like .warmup, .running, ...
    var muscleGroup: MuscleGroup    // muscle group
    var isCompleted: Bool           // completion state
  
    init(version: Int = exerciseVersion, id: UUID = UUID(), name: String = "", description: String = "", notes: String = "", device: String = "" , category: ExerciseCategory = .gym, image: String = "" , start: Date = Date.now, end: Date = Date.now, sets: [Set] = [], duration: Duration = .seconds(15*60), muscleGroup: MuscleGroup = .body, isCompleted: Bool = false) {
        self.version = version
        self.id = id
        self.name = name
        self.description = description
        self.notes = notes
        self.device = device
        self.category = category
        self.image = image
        self.start = start
        self.end = end
        self.sets = sets
        self.duration = duration
        self.muscleGroup = muscleGroup
        self.isCompleted = isCompleted
    }
    
    mutating func startExcercise() {
        self.start = Date.now
    }
    
    mutating func endExcercise() {
        self.end = Date.now
    }
    
    /// Save exercise to global exercise list and makes change persistent.
    ///
    /// If an exercise w/ same id already exists it list, it will be updated.
    /// A new exercise is created if no matching id is found and appended to list.
    /// - Parameter ex: excercise
    func save() {
        
        var found = false
        var indexFound = 0
        
        // find item with matching id
        for i in 0..<globals.exerciseList.count {
            if self.id == globals.exerciseList[i].id {
                exLog.debug("save(): match for id=\(self.id,privacy: .public) at index \(i,privacy: .public)")
                found = true
                indexFound = i
            }
        }
        
        if found { // matching id, update global exerciseList
            exLog.notice("save(): updating exercise \(self.name,privacy: .public), id=\(self.id,privacy: .public)")
            globals.exerciseList.insert(self, at: indexFound)
            globals.exerciseList.remove(at: indexFound+1)
 
        } else {
            exLog.notice("save(): appending new exercise \(self.name,privacy: .public), id=\(self.id,privacy: .public)")
            globals.exerciseList.append(self)
        }
        
        // sort list before saving
        globals.sortExerciseList()
        // make persistent
        saveToAppSupportDir(filename:exercisesFile, data:globals.exerciseList)
    }
    
}





