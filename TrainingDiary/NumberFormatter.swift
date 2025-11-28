//
//  NumberFormatter.swift
//  TrainingDiary
//
//  Created by Dieter on 28.11.25.
//

import SwiftUI

struct WeightInputView: View {
    @State private var weight: Double = 0.0
    private let numberFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 2
        return f
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Enter weight (kg):")
            TextField("0.0", value: $weight, formatter: numberFormatter)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
            Text("You entered: \(weight, specifier: "%.2f") kg")
        }
        .padding()
    }
}



#Preview {
    WeightInputView()
}
