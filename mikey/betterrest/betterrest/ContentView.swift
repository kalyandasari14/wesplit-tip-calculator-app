//
//  ContentView.swift
//  betterrest
//
//  Created by kalyan on 1/31/26.
//
import CoreML
import SwiftUI


struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    
    
    var sleepResult: String{
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hours = (components.hour ?? 0)*60*60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hours + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount)
           )
            
            let sleepTIme = wakeUp - prediction.actualSleep
            
            return "your ideal bed time is :" + " " + sleepTIme.formatted(date: .omitted, time: .shortened)
           
        }catch{
         return "there was an error"
        }
    }
    
   static var defaultWakeTime:Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section("When do u want to wake up??"){
                    DatePicker("Please enter a time", selection: $wakeUp,displayedComponents: .hourAndMinute).labelsHidden()}
            
                Section("Desired amount of sleep ??"){
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12,step: 0.25)}
               
                    Section("how many cofees do u drink a day ??"){
                        Picker("Cofee amount", selection: $coffeeAmount){
                            ForEach(1..<21){number in
                                Text("\(number)")
                                
                            }
                        }}
                
                
                Section("What time you need to sleep"){
                    Text(sleepResult).font(.title3)
                    Text("great day a head")}
               
                
            }.navigationTitle("Better Rest").navigationBarTitleDisplayMode(.large)
        }
        .padding()
    }
    
    
}

#Preview {
    ContentView()
}
