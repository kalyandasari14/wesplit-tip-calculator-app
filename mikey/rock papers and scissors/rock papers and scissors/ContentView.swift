//
//  ContentView.swift
//  rock papers and scissors
//
//  Created by kalyan on 1/30/26.
//

import SwiftUI

struct ContentView: View {
    let moves = ["rock","paper","scissors"]
    @State private var computerChoices = Int.random(in: 0..<3)
    @State private var shouldAnswer = Bool.random()
    
    @State private var score = 0
    @State private var showingResult = false
    @State private var questionCount = 1
    var body: some View {
        VStack{
            Spacer()
            Text("Computer has Played")
                .font(.headline)
            Text(moves[computerChoices])
                .font(.system(size: 100))
            
            if shouldAnswer{
                Text("Who is the winner??")
                    .foregroundStyle(.green).font(.title)
            }else{
                Text("who is the loser??")
                    .foregroundStyle(.red).font(.title)
                
            }
            
            HStack{
                ForEach(0..<3){number in
                    Button(moves[number]){
                        play(choice: number)
                        
                    }.font(.system(size: 40))
                }
            }
            Spacer()
            Text("Score :\(score)")
                .font(.subheadline)
            Spacer()
               
        }.alert("Gameover", isPresented: $showingResult ){
            Button("play again",action: reset)
        } message: {
            Text("your score is \(score)")
        }
    }
    
    func play(choice:Int){
        let winningMoves = [1,2,0]
        let didwin : Bool
        
        if shouldAnswer{
            didwin = choice == winningMoves[computerChoices]
        }else{
             didwin = winningMoves[choice] == computerChoices
        }
        
        if didwin{
            score += 1
        }else {
            score -= 1
        }
        
        if questionCount == 10{
            showingResult = true
        } else{
            computerChoices = Int.random(in: 0..<3)
            shouldAnswer.toggle()
            questionCount += 1
        }
    }
    
    func reset(){
        computerChoices = Int.random(in: 0..<3)
        shouldAnswer = Bool.random()
        score = 0
        questionCount = 0
    }
     
}

#Preview {
    ContentView()
}
