//
//  ContentView.swift
//  moonshot
//
//  Created by kalyan on 2/6/26.
//

import SwiftUI



struct ContentView: View {
    
    let astronauts: [String:Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [GridItem(.adaptive(minimum: 150, maximum: .infinity))]
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(missions) { mission in
                        NavigationLink{
                    MissionView(mission: mission, astronauts: astronauts)
                        }label: {
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack{
                                    Text(mission.displayName)
                                        .foregroundStyle(.yellow)
                                    Text(mission.formattedLaunchDate).font(.caption)
                                        .foregroundStyle(.white)
                                
                                }.padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }.clipShape(.rect(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                )
                        }
                    }
                }.padding([.horizontal,.bottom])
            }.navigationTitle("MOON SHOT")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                
        }
    }
}

#Preview {
    ContentView()
}
