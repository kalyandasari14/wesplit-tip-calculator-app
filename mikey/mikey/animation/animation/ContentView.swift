//
//  ContentView.swift
//  animation
//
//  Created by kalyan on 2/2/26.
//

import SwiftUI

struct ContentView: View {
    
    let letters = Array("hello swiftui")
    
    @State private var animationAmount = 1.0
    @State private var animationAMount = 0.0
    
    @State private var enabled = false
    
    @State private var dragAmount = CGSize.zero
    
    @State private var isShown = false
    
    
    
    var body: some View {
        VStack(spacing: 40){
            VStack{
                Stepper("scale amount : \(animationAmount)" ,value: $animationAmount.animation(),in: 2...10)
                Spacer()
                Button("Tap Me") {
                    animationAmount += 1
                }
                .padding()
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .scaleEffect(animationAmount)
                // 1. We keep the main button sharp.
                // 2. We add an OVERLAY that is blurry and masked.
                .overlay(
                    Capsule()
                        .fill(.red)
                        .blur(radius: (animationAmount - 1) * 3)
                        .allowsHitTesting(false)
                        .opacity(2 - animationAmount)
                )
                .animation(.easeInOut(duration: 0), value: animationAmount)
                .onAppear{
                    animationAmount = 2
                }
                Spacer()
            }
            
            VStack{
                Button("tap me"){
                    withAnimation{
                        animationAMount += 360}
                    enabled.toggle()
                }
                    .padding(40)
                    .background(enabled ? .red : .blue)
                    .foregroundStyle(.yellow)
                    .rotation3DEffect(.degrees(animationAMount), axis: (x: 1, y: 1, z: 1))
                    .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
                    .animation(.spring(duration: 0.5,bounce: 0.9), value: enabled)
                    
            }
            
            VStack{
                LinearGradient(colors: [.yellow,.red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 300,height: 200)
                    .clipShape(.rect(cornerRadius: 10))
                    .offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged{dragAmount = $0.translation}
                                .onEnded{_ in dragAmount = .zero}
                        
                    )
                    .animation(.bouncy, value: dragAmount)
            }
            
            HStack{
                
                ForEach(0..<letters.count, id: \.self){number in
                    Text(String(letters[number]))
                        .padding(5)
                        .font(.title)
                        .background(enabled ? .blue : .red)
                        .offset(dragAmount)
                        .animation(.linear.delay(Double(number)/20), value: dragAmount)
                        .gesture(
                            DragGesture()
                                .onChanged{dragAmount = $0.translation}
                                .onEnded{_ in dragAmount = .zero
                                    enabled.toggle()}
                            
                        )
                }
                
            }
            
            VStack{
                Button("Tap Me"){
                    isShown.toggle()
                }
                if isShown{
                    Rectangle()
                        .fill(.red)
                        .frame(width: 50,height: 50)
                        .transition(.asymmetric(insertion: .slide, removal: .opacity))
                        
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
