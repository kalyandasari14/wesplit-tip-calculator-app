//
//  ContentView.swift
//  mikey
//
//  Created by kalyan on 1/28/26.
//

import SwiftUI

struct ContentView: View {
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        NavigationStack{
            ZStack {
                
                AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                        Text(countries[correctAnswer])
                    }

                    ForEach(0..<3) { number in
                        Button {
                           // flag was tapped
                        } label: {
                            Image(countries[number])
                        }
                    }
                }
                
            }.ignoresSafeArea()
                .navigationTitle("GUESS THE FLAG")
        }
    }
}

#Preview {
    ContentView()
}
