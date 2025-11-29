//
//  ExcerciseAddUpdateView.swift
//  TrainingDiary
//
//  Created by Dieter on 28.11.25.
//

import SwiftUI

struct ExcerciseAddUpdateView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var exercise: Exercise
    @FocusState private var kbFocus: Bool
    
    // editable fields for creating default sets
    @State var setCount: Int = 0
    @State var repsCount: Int = 0
    @State var weight: Double = 0.0
    @State var pause: Duration = .zero  // pause after a set
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                //              Color.yellow.opacity(0.5).edgesIgnoringSafeArea(.all)
                
//                                                LinearGradient(colors: [Color.red,Color.green],startPoint: .top,endPoint:.bottom)
//                                                    .opacity(0.8).ignoresSafeArea()
                
                VStack(spacing: 10) {
                    
                    HStack {
                        Text("General settings")
                            .font(.caption.bold())
                        Spacer()
                    }
                    
                    GlassEffectContainer {
                        
                        LabeledContent("Name:") {
                            TextField("enter name",text: $exercise.name)
                                .font(.title.bold())
                                .textFieldStyle(.roundedBorder)
                                .focused($kbFocus)
                                .padding()
                        }
                        
                        LabeledContent("Category:") {
                            Picker("", selection: $exercise.category) {
                                ForEach(ExerciseCategory.allCases, id: \.self) { category in
                                    Label(category.displayName, systemImage: category.iconName)
                                        .tag(category)
                                }
                            }
                            .pickerStyle(.menu)
                            .padding()
                        }
                        
                        LabeledContent("Description:") {
                            TextField("optional",text: $exercise.description)
                                .textFieldStyle(.roundedBorder)
                                .focused($kbFocus)
                                .padding()
                        }
                        
                        if exercise.category != .gym {
                            LabeledContent("Duration") {
                                HourMinutePicker(duration: $exercise.duration)
                                    .padding()
                            }
                            Spacer()
                        }
                    }
                    .font(.headline)
                    .padding(.leading, 10)
                    .glassEffect(.regular,in: .rect(cornerRadius: 20.0))
                    
                    
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
                            GlassEffectContainer {
                                
                                LabeledContent("Number of sets:") {
                                    Stepper("\(setCount)", value: $setCount, in: 0...10)
                                        .font(.title2.bold())
                                        .padding()
                                }
                                LabeledContent("Reps:") {
                                    Stepper("\(repsCount)", value: $repsCount, in: 0...10)
                                        .font(.title2.bold())
                                        .padding()
                                }
                                LabeledContent("Weight:") {
                                    HStack {
                                        Spacer()
                                        TextField("0.0", value: $weight, format: .number)
                                            .textFieldStyle(.roundedBorder)
                                            .font(.title2.bold())
                                            .keyboardType(.numberPad)
                                            .focused($kbFocus)
                                            .frame(width: 80)
                                            .padding(.trailing)
                                    }
                                }
                                
                                LabeledContent("Pause:") {
                                    MinuteSecondPicker(duration: $pause)
                                        .padding()
                                }
                                
                                Text("Above settings are applied when creating sets. You can adjust settings for each set individually.")
                                    .font(.caption)
                                    .padding(.bottom, 10)
                                
                                
                                
                            }
                            .font(.headline)
                            .padding(.leading, 10)
                            .glassEffect(.regular,in: .rect(cornerRadius: 20.0))
                            
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
                            Spacer()
                            
                        } else {
                            // exercise has sets defined, show sets
                            List {
                                
                                ForEach(exercise.sets.indices, id: \.self) { index in
                                    
                                    VStack(alignment: .leading) {
                                        GroupBox {
                                            HStack {
                                                let wup = exercise.sets[index].isWarmup ? " (warm-up)" : ""
                                                Text("Set \(index+1)").font(Font.title3.bold())
                                                Text("\(wup)").font(.body)
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
                            .listStyle(.plain)
                            .ignoresSafeArea(edges: .bottom)
                            
                            //                            HStack {
                            //                                Button(
                            //                                    action: {
                            //                                        exercise.sets.append(Set())
                            //                                    },
                            //                                    label: {
                            //                                        Image(systemName: "plus.circle")
                            //                                            .font(.title)
                            //                                    }).buttonStyle(.glass)
                            //                                Spacer()
                            //                                Button(
                            //                                    action: {
                            //                                        exercise.sets.removeLast()
                            //                                    },
                            //                                    label: {
                            //                                        Image(systemName: "minus.circle")
                            //                                            .font(.title)
                            //                                    })
                            //                                .disabled(exercise.sets.count <= 1)
                            //                                .buttonStyle(.glass)
                            //                            }
                            //                            Spacer()
                        }
                        
                    }
                    
                    
                }
                .padding()
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard, content: {
                        Spacer()
                        // button to hide keyboard
                        Button(action: { kbFocus=false },
                               label: {Image(systemName: "keyboard.chevron.compact.down").font(.system(size: 15))
                        })
                    })
                    ToolbarItem(placement: .topBarLeading) {
                        Button(
                            action: {
                                // TBD
                                dismiss()
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
                                // remember to delete sets if cat is othe than .gym when saving
                            },
                            label: {
                                Text(
                                    "Save"
                                )
                            })
                        .buttonStyle(.glassProminent)
                        .disabled(exercise.name.hasWhiteSpaceOnly())
                    }
                    
                    if !exercise.sets.isEmpty {
                        
                        ToolbarItem(placement: .bottomBar) {
                            Button(
                                action: {
                                    exercise.sets.append(Set())
                                },
                                label: {
                                    Image(systemName: "plus.circle")
                                        .font(.title)
                                })
                        }
                        
                        ToolbarItem(placement: .bottomBar) {
                            Button(
                                action: {
                                    exercise.sets.removeLast()
                                },
                                label: {
                                    Image(systemName: "minus.circle")
                                        .font(.title)
                                })
                            .disabled(exercise.sets.count <= 1)
                        }
                    }
                } // VStack
                .navigationTitle("Exercise")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
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
