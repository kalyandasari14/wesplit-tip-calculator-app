//
//  ContentView.swift
//  my practice
//
//  Created by kalyan on 1/31/26.
//

import SwiftUI

struct ContentView: View {
    @State var tipPercentage = 20
    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    Section("Select your tip") { // Header is visible
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(0..<101) {
                                Text($0, format: .percent)
                            }
                        }
                        // Use .pickerStyle(.menu) to make it show up right in the row
                        .pickerStyle(.menu)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
