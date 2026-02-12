//
//  ContentView.swift
//  navigation
//
//  Created by kalyan on 2/10/26.
//

import SwiftUI

struct Student: Hashable {
    var id = UUID()
    var name: String = "mikey"
    var age: Int
}

struct ContentView: View {
    @State private var path = [Int]()
    var body: some View {
        NavigationStack(path: $path){
            Button("show 32"){
                path = [32]
            }
            Button("show 64"){
                path.append(64)
            }
            
            Button("show 32 and show 64"){
                path.append(32)
                path.append(65)
            }
            
            .navigationDestination(for: Int.self){selection in
                     Text("\(selection)")}
            
        }
    }
}

#Preview {
    ContentView()
}
