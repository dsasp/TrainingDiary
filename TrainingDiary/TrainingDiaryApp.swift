//
//  TrainingDiaryApp.swift
//  TrainingDiary
//
//  Created by Dieter on 26.11.25.
//

import SwiftUI



@main
struct TrainingDiaryApp: App {
    
    // Create Globals singelton.
    @StateObject private var globals = Globals.shared
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(globals)
        }
    }
}
