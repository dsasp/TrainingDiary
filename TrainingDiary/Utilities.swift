//
//  Utilities.swift
//  TrainingDiary
//
//  Created by Dieter on 28.11.25.
//

import SwiftUI

struct MinuteSecondPicker: View {
    @Binding var duration: Duration
    
    // Derived bindings for minutes/seconds
    private var minutesBinding: Binding<Int> {
        Binding(
            get: { Int(duration.components.seconds / 60) },
            set: { newMinutes in
                let secs = Int(duration.components.seconds % 60)
                duration = .seconds(newMinutes * 60 + secs)
            }
        )
    }
    
    private var secondsBinding: Binding<Int> {
        Binding(
            get: { Int(duration.components.seconds % 60) },
            set: { newSeconds in
                let mins = Int(duration.components.seconds / 60)
                duration = .seconds(mins * 60 + newSeconds)
            }
        )
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Picker("Minutes", selection: minutesBinding) {
                ForEach(0..<61, id: \.self) { m in
                    Text("\(m) min").tag(m)
                }
            }
            .frame(maxWidth: .infinity)
            .clipped()
            
            Picker("Seconds", selection: secondsBinding) {
                ForEach(0..<60, id: \.self) { s in
                    Text("\(s) sec").tag(s)
                }
            }
            .frame(maxWidth: .infinity)
            .clipped()
        }
        .pickerStyle(.menu)
    }
}

struct HourMinuteSecondPicker: View {
    @Binding var duration: Duration
    
    private var hoursBinding: Binding<Int> {
        Binding(
            get: { Int(duration.components.seconds / 3600) },
            set: { newHours in
                let total = Int(duration.components.seconds)
                let minutes = (total % 3600) / 60
                let seconds = total % 60
                duration = .seconds(newHours * 3600 + minutes * 60 + seconds)
            }
        )
    }
    
    private var minutesBinding: Binding<Int> {
        Binding(
            get: { (Int(duration.components.seconds) % 3600) / 60 },
            set: { newMinutes in
                let total = Int(duration.components.seconds)
                let hours = total / 3600
                let seconds = total % 60
                let clamped = max(0, min(59, newMinutes))
                duration = .seconds(hours * 3600 + clamped * 60 + seconds)
            }
        )
    }
    
    private var secondsBinding: Binding<Int> {
        Binding(
            get: { Int(duration.components.seconds % 60) },
            set: { newSeconds in
                let total = Int(duration.components.seconds)
                let hours = total / 3600
                let minutes = (total % 3600) / 60
                let clamped = max(0, min(59, newSeconds))
                duration = .seconds(hours * 3600 + minutes * 60 + clamped)
            }
        )
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Picker("Hours", selection: hoursBinding) {
                ForEach(0..<24, id: \.self) { h in
                    Text("\(h) h").tag(h)
                }
            }
            .frame(maxWidth: .infinity)
            .clipped()
            
            Picker("Minutes", selection: minutesBinding) {
                ForEach(0..<60, id: \.self) { m in
                    Text("\(m) m").tag(m)
                }
            }
            .frame(maxWidth: .infinity)
            .clipped()
            
            Picker("Seconds", selection: secondsBinding) {
                ForEach(0..<60, id: \.self) { s in
                    Text("\(s) s").tag(s)
                }
            }
            .frame(maxWidth: .infinity)
            .clipped()
        }
        .pickerStyle(.menu)
    }
}

struct HourMinutePicker: View {
    @Binding var duration: Duration
   
    private var hoursBinding: Binding<Int> {
        Binding(
            get: { Int(duration.components.seconds / 3600) },
            set: { newHours in
                let total = Int(duration.components.seconds)
                let minutes = (total % 3600) / 60
                let seconds = total % 60
                duration = .seconds(newHours * 3600 + minutes * 60 + seconds)
            }
        )
    }
    
    private var minutesBinding: Binding<Int> {
        Binding(
            get: { (Int(duration.components.seconds) % 3600) / 60 },
            set: { newMinutes in
                let total = Int(duration.components.seconds)
                let hours = total / 3600
                let seconds = total % 60
                let clamped = max(0, min(59, newMinutes))
                duration = .seconds(hours * 3600 + clamped * 60 + seconds)
            }
        )
    }

    var body: some View {
        HStack {
            Picker("Hours", selection: hoursBinding) {
                ForEach(0..<24, id: \.self) { h in
                    Text("\(h) h").tag(h)
                }
            }
            .frame(maxWidth: .infinity)
            .clipped()
            .pickerStyle(.menu)
            
            Picker("Minutes", selection: minutesBinding) {
                ForEach(0..<60, id: \.self) { m in
                    Text("\(m) m").tag(m)
                }
            }
            .frame(maxWidth: .infinity)
            .clipped()
            .pickerStyle(.menu)
        }
    }
}

// AI generated
let numberFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.numberStyle = .decimal
    f.maximumFractionDigits = 1
    return f
}()
