//
//  ExerciseListView.swift
//  TrainingDiary
//
//  Created by Dieter on 30.11.25.
//


// TODOs
//  show initial list by category
//  sort by muscle group
//  sort by name
//  sort by category


import SwiftUI

struct ExerciseListView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var globals: Globals
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                appBackground
                    .opacity(0.8).ignoresSafeArea()
                
                VStack {
                    if globals.exerciseList.isEmpty {
                        Text("Sorry")
                            .font(Font.title.bold())
                            .padding(.top,50)
                        Text("No exercise found.")
                            .font(Font.title2.bold())
                            .padding()
                            Spacer()
                        
                        Button("Add Exercises") {
                            for i in 0..<20 {
                                let newExercise = Exercise(id: UUID(), name: "Exercise \(i)")
                                globals.exerciseList.append(newExercise)
                            }
                        }.buttonStyle(.glass)
                        Spacer()
                        
                    } else {
                        HStack {
                            Text("Exercises").font(Font.caption.bold())
                            Spacer()
                        }
                        List {
                            ForEach(globals.exerciseList) { e in
                                HStack {
                                    Image(systemName: e.category.iconName)
                                        .font(.system(size: 20))
                                        .frame(width: 35,alignment: .leading)
                                    VStack(alignment: .leading) {
                                        Text(e.name)
                                            .fontWeight(.bold)
                                        if e.category == .gym {
                                            HStack {
                                                Text("Muscle group: \(e.muscleGroup.displayName)")
                                                Text("Sets: \(e.sets.count)")
                                                Spacer()
                                            }
                                        } else {
                                            HStack {
                                                Text("Duration: \(hmsString(from: e.duration))")
                                                Spacer()
                                            }
                                            
                                        }
                                    }
                                    
                                }
                            }
                            .onDelete(perform: deleteExercises)
//                            .onMove(perform: moveExercises)
                        }
                        .listStyle(.plain)
                        .padding(.bottom,70) // ensure last item not covered by bottomBar when scrolling up
                    }
                }
                .padding()
                .navigationTitle(Text("Exercises"))
                .navigationBarTitleDisplayMode(.inline)
  
            }
            .ignoresSafeArea(.container, edges: .bottom) // show list content under bottomBar
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    NavigationLink(destination: ExcerciseAddUpdateView(exercise: Exercise(name: "New Exercise")), label: {
                            Text("New Exercise").font(Font.title.bold())
                            .padding()
                    })
                }
            }
        }
  
    }
    
    /// Deletes exercises from global exerciseList and make change persistent.
    /// - Parameter indexSet: indices for archers to be deleted
    func deleteExercises(indexSet: IndexSet) {
        for i in indexSet { globals.exerciseList.remove(at: i) }
        globals.sortExerciseList()
        saveToAppSupportDir(filename: exercisesFile, data: globals.exerciseList)
    }
    
    /// Move exercises to new position in global exerciseList and make change persistent.
    /// - Parameters:
    ///   - source: from position
    ///   - destination: to position
    func moveExercises( from source: IndexSet, to destination: Int)
    {
        globals.exerciseList.move(fromOffsets: source, toOffset: destination )
        globals.sortExerciseList()
        saveToAppSupportDir(filename: exercisesFile, data: globals.exerciseList)
    }
        
}

#Preview {
    ExerciseListView()
        .environmentObject(Globals.shared)
}
