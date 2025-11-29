//
//  WorkoutsView.swift
//  TrainingDiary
//
//  Created by Dieter on 29.11.25.
//

import SwiftUI

struct WorkoutsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var globals: Globals
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                appBackground
                    .opacity(0.8).ignoresSafeArea()
                
                VStack {
                    if globals.workoutList.isEmpty {
                        Text("Sorry")
                            .font(Font.title.bold())
                            .padding(.top,50)
                        Text("No workouts found.")
                            .font(Font.title2.bold())
                            .padding()
                            Spacer()
                        
                        Button("Add Workouts") {
                            for i in 0..<20 {
                                let newWorkout = Workout(id: UUID(), name: "Workout \(i)", iconName: "pencil")
                                globals.workoutList.append(newWorkout)
                                
                            }
                        }.buttonStyle(.glass)
                        Spacer()
                        
                    } else {
                        HStack {
                            Text("Workouts").font(Font.caption.bold())
                            Spacer()
                        }
                        List {
                            ForEach(globals.workoutList) { workout in
                                HStack {
                                    Image(systemName: workout.iconName)
                                        .font(.system(size: 20))
                                    Text(workout.name)
                                    Text(workout.start, style: .date)
                                }
                            }
                         
                        }
                        .listStyle(.plain)
                    }
                }
                .padding()
                .navigationTitle(Text("Workouts"))
                .navigationBarTitleDisplayMode(.inline)
  
            }
            .ignoresSafeArea(.container, edges: .bottom) // show list content under bottomBar
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(
                        action: {
                            // TBD
                            // remember to delete sets if cat is othe than .gym when saving
                        },
                        label: {
                            Text("New Workout")
                                .font(Font.title.bold())
                        })
                    .padding()
                   
                }
            }
        }
  
    }
}

#Preview {
    WorkoutsView()
        .environmentObject(Globals.shared)
}
