//
//  ExcerciseAddUpdateView.swift
//  TrainingDiary
//
//  Created by Dieter on 28.11.25.
//

import SwiftUI

struct ExcerciseAddUpdateView: View {
    
    @State var exercise: Exercise
    
    // editable fields when creating default sets
    @State var setCount: Int = 0
    @State var repsCount: Int = 0
    @State var weight: Double = 0.0
    @State var pause: Duration = .zero  // pause after a set
    @State var isWarmup: Bool = false   // true if warmup set
    
    var body: some View {
        
        NavigationStack {
            ZStack {
//                                LinearGradient(colors: [Color.red,Color.green],startPoint: .top,endPoint:.bottom)
//                                    .opacity(0.8).ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        Text("Create or edit an exercise")
                            .font(.body)
                    }.padding(.bottom,15)
                    
                    
                    HStack {
                        Text("General settings")
                            .font(.caption.bold())
                        Spacer()
                    }
                    
                    GroupBox {
                        LabeledContent("Category") {
                            Picker("", selection: $exercise.category) {
                                ForEach(ExerciseCategory.allCases, id: \.self) { category in
                                    Label(category.displayName, systemImage: category.iconName)
                                        .tag(category)
                                }
                            }.pickerStyle(.menu)
                        }
                        LabeledContent("Name") {
                            TextField("name is required",text: $exercise.name)
                        }
                        
                        LabeledContent("Description") {
                            TextField("optional",text: $exercise.description)
                        }
                        
                        if exercise.category != .gym {
                            LabeledContent("Duration") {
                                HourMinutePicker(duration: $exercise.duration)
                            }
                        }
                    }
                    .font(.headline)
                    
                    // Show sets for category .gym only
                    if exercise.category == .gym {
                        
                        HStack {
                            Text("Sets")
                                .padding(.top,10)
                                .font(.caption.bold())
                            Spacer()
                        }
                        
                        if exercise.sets.isEmpty {
                            // exercise has not sets,
                            //  allow creating group of new sets with identical settings
                            GroupBox {
                                
                                LabeledContent("Number of sets:") {
                                    Stepper("\(setCount)", value: $setCount, in: 0...10)
                                }
                                
                                LabeledContent("Weight:") {
                                    HStack {
                                        Spacer()
                                        TextField("0.0", value: $weight, format: .number)
                                              .textFieldStyle(.roundedBorder)
                                              .keyboardType(.numberPad)
                                              .frame(width: 80)
                                    }
                                }
                                LabeledContent("Reps:") {
                                    Stepper("\(repsCount)", value: $repsCount, in: 0...10)
                                }
                                LabeledContent("Pause:") {
                                    MinuteSecondPicker(duration: $pause)
                                }
                                
                                HStack {
                                    Text("Above settings are applied when creating sets. You can adjust settings for each set individually.")
                                        .font(.caption)
                                    Spacer()
                                }
                                
                            }.font(.headline)
                            
                            Button(
                                action: {
                                    for _ in 0..<setCount {
                                        let w = weight
                                        let s = Set(weight: w, reps: repsCount, pause: pause)
                                        exercise.sets.append(s)
                                    }
                                },
                                label: {
                                    Text(
                                        "Create sets"
                                    )
                                })
                            .buttonStyle(.glass)
                            .disabled(setCount == 0)
                            
                        } else {
                            // exercise has sets defined, show sets
                            ScrollView {
                                ForEach(exercise.sets.indices, id: \.self) { index in
                                    
//                                    let _ = print(exercise.sets[index])
                                    
                                    VStack(alignment: .leading) {
                                        GroupBox {
                                            HStack {
                                                let wup = exercise.sets[index].isWarmup ? " (warm-up)" : ""
                                                Text("Set \(index+1)").font(Font.title3.bold())
                                                Text("\(wup)").font(.body.italic())
                                                Spacer()
                                            }
                                            
                                            if index == 0 {
                                                LabeledContent("Warm-up:") {
                                                    Toggle("", isOn: $exercise.sets[index].isWarmup)
                                                }
                                            }
                                            
                                            LabeledContent("Reps:") {
                                                Stepper("\(exercise.sets[index].reps)", value: $exercise.sets[index].reps, in: 0...10)
                                            }
                                            
                                            LabeledContent("Weight:") {
                                                TextField("0.0", value: $exercise.sets[index].weight, format: .number)
                                                      .textFieldStyle(.roundedBorder)
                                                      .keyboardType(.numberPad)
                                                      .frame(width: 80)
                                            }
                                            
                                            LabeledContent("Pause:") {
                                                MinuteSecondPicker(duration: $exercise.sets[index].pause)
                                            }
                                            
                                        }.font(.headline)
                                        
                                    }
                                }
                                
                            }
                            
                            HStack {
                                Button(
                                    action: {
                                        exercise.sets.append(Set())
                                    },
                                    label: {
                                        Image(systemName: "plus.circle")
                                            .font(.title)
                                    }).buttonStyle(.glass)
                                Spacer()
                                Button(
                                    action: {
                                        exercise.sets.removeLast()
                                    },
                                    label: {
                                        Image(systemName: "minus.circle")
                                            .font(.title)
                                    }).buttonStyle(.glass)
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(
                            action: {
                                // TBD
                            },
                            label: {
                                Text(
                                    "Cancel"
                                )
                            })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(
                            action: {
                                // TBD
                            },
                            label: {
                                Text(
                                    "Save"
                                )
                            })
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button(
                            action: {
                                // TBD
                            },
                            label: {
                                Text("Save").font(.title).padding()
                            })//.buttonStyle(.glassProminent)
                    }
                    
                } // VStack
                .navigationTitle("Exercise")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    if exercise.category != .gym {
                        if exercise.duration == .zero {
                            exercise.duration = .seconds(15*60+0)
                        }
                    }
                }
                
            }
        } // ZStack
        
    }
}


#Preview {
    ExcerciseAddUpdateView(exercise: Exercise())
}
