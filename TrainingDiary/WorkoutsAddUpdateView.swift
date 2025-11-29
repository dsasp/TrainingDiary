//
//  WorkoutsAddUpdateView.swift
//  TrainingDiary
//
//  Created by Dieter on 29.11.25.
//

import SwiftUI

struct WorkoutsAddUpdateView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var globals: Globals
    @FocusState private var kbFocus: Bool
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                appBackground
                    .opacity(0.8).ignoresSafeArea()
                
                VStack {
                    if globals.workoutList.isEmpty {
                        
                        Text("Create and update workouts")
                            .font(Font.title3.bold())
                        
                    } else {
                        
                        
                        
                        
                    }
                    
                    
                    
                  Spacer()
                }
 
                
            }
            .navigationTitle("Workouts")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    WorkoutsAddUpdateView()
        .environmentObject(Globals.shared)
}
