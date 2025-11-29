//
//  TrainingsView.swift
//  TrainingDiary
//
//  Created by Dieter on 29.11.25.
//

import SwiftUI

struct TrainingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var globals: Globals
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                appBackground
                    .opacity(0.8).ignoresSafeArea()
                
                VStack {
                    
                    Text("Trainings View")
                }
                .navigationTitle(Text("Trainings"))
                .navigationBarTitleDisplayMode(.inline)
  
                
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(
                        action: {
                            // TBD
                            // remember to delete sets if cat is othe than .gym when saving
                        },
                        label: {
                            Text("New")
                                .fontWeight(.bold)
                        })
                }
            }
        }
  
    }
}

#Preview {
    TrainingsView()
        .environmentObject(Globals.shared)
}
