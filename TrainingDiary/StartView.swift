//
//  StartView.swift
//  TrainingDiary
//
//  Created by Dieter on 26.11.25.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        
    
        
        NavigationStack {
            
            ZStack {
//                LinearGradient(colors: [Color.red,Color.green],startPoint: .top,endPoint:.bottom)
//                .opacity(0.8).ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    
                    
                    GlassEffectContainer {
                        Text("Training Diary")
                        
                            .padding(.all)
                           
                    }
                    .glassEffect(.regular, in: .rect(cornerRadius: 30))
                    .padding()
                    
                    Text("Create training plans and track your personal workouts.")
                        .font(.title2).fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 20).padding(.trailing, 20).padding(.bottom, 30)
                    
                    Button(action: {
                        
                        // TBD
                        
                    }, label: {
                        
                        Text("Start Workout")
                            .font(.title).fontWeight(.semibold)
                            .padding()
                        
                    }).buttonStyle(.glassProminent)
                    
                    
                    Spacer()
                    
                    Text("Trainings Diary")
                        .font(.title)
                        .padding()
                        .glassEffect(.regular, in: .rect(cornerRadius: 20))
                    
                    HStack {
                        Button(action: {},
                               label: {
                            VStack {
                                Image(systemName: "person")
                                    .font(Font.title.bold())
                                Text("Profile").font(.caption)
                            }.frame(width: 80, height: 60)
                        }).buttonStyle(GlassButtonStyle())
                        Button(action: {},
                               label: {
                            VStack {
                                Image(systemName: "figure.strengthtraining.traditional")
                                    .font(Font.title.bold())
                                Text("Plan").font(.caption)
                            }.frame(width: 80, height: 60)
                        }).glassEffect()
                        Button(action: {},
                               label: {
                            VStack {
                                Image(systemName: "calendar")
                                    .font(Font.largeTitle.bold())
                                Text("Workouts").font(.caption)
                            }.frame(width: 80, height: 60)
                        }).glassEffect()
                        
                        
                    }
                    
                    GlassEffectContainer() {
                        HStack {
                            Button("Button1") {
                                //
                            }.buttonStyle(GlassButtonStyle())
                            Button("Button2") {
                                //
                            }.buttonStyle(GlassButtonStyle())
                            Button("Button3") {
                                //
                            }.buttonStyle(GlassButtonStyle())
                        }
                    }
                    .padding()
                    .glassEffect(.regular.tint(.yellow))
                    
                    
                    Spacer()
                }
                .padding()
                .toolbar {
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {},
                               label: {
                            VStack {
                                Image(systemName: "questionmark")
                                    .font(Font.headline)
                            }
                        }).buttonStyle(GlassButtonStyle())
                        
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {},
                               label: {
                            VStack {
                                Image(systemName: "person")
                                    .font(Font.title.bold())
                                Text("Profile").font(.caption)
                            }//.frame(width: buttonWidth, height: buttonHeight)
                        }).buttonStyle(.glass)
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {},
                               label: {
                            VStack {
                                Image(systemName: "figure.strengthtraining.traditional")
                                    .font(Font.title.bold())
                                Text("Plans").font(.caption)
                            }
                        }).buttonStyle(GlassButtonStyle())
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button(
                            action: {
                            },
                            label: {
                                VStack {
                                    Image(
                                        systemName: "chart.bar.xaxis"
                                    )
                                    .font(
                                        Font.largeTitle.bold()
                                    )
                                    Text(
                                        "Statistics"
                                    ).font(
                                        .caption
                                    )
                            }.frame(width: buttonWidth, height: buttonHeight)
                        }).glassEffect()
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {},
                               label: {
                            VStack {
                                Image(systemName: "gear")
                                    .font(Font.largeTitle.bold())
                                Text("Settings").font(.caption)
                            }.frame(width: buttonWidth, height: buttonHeight)
                        }).buttonStyle(GlassButtonStyle())
                        
                    }
                }
                
            } // ZStack
          
        } // NavigationStack
    }
}

#Preview {
    StartView()
}


