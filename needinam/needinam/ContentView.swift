//
//  ContentView.swift
//  needinam
//
//  Created by kalyan on 1/27/26.
//

import SwiftUI

struct ContentView: View {
    @State var numberOfPeople = 2
    @State var checkAmount = 0
    @State var tippingPercentage = 20
    
    var grandTotal: Double{
        let amount = Double(checkAmount)
        let tip = Double(tippingPercentage)
        
        let tipValue = amount/100 * tip
        
        let newtotal = amount + tipValue
        return newtotal
    }
    var totalPerPerson:Double{
        let amount = Double(checkAmount)
        let people = Double(numberOfPeople)
        let tip = Double(tippingPercentage)
        
        let tipValue = amount/100 * tip
        
        let newtotal = amount + tipValue
        
        return newtotal/people
    }
    
    var amountColor : Color{
        switch tippingPercentage{
        case 0...9 : .red
        case 10...30: .blue
        default : .green
        }
    }
    
    var icon : String{
        switch tippingPercentage{
        case 0...9 :
            return "exclamationmark.triangle.fill"
        case 10...30:
            return "face.smiling"
        default :
            return "star.fill"
        }
    }
    
    
    var body: some View{
        NavigationStack{
            Form{
                Section{
                    TextField("amount",value: $checkAmount,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))}
                Section{
                    Picker("Number Of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0)")
                        }
                    }
                }
                Section{
                    Picker("Tip Amount", selection: $tippingPercentage){
                        ForEach(0..<101){
                            Text("\($0) %")
                            
                        }
                    }
                }
                
                Section("Grand Total Before splitting"){
                    HStack{
                        Image(systemName: icon)
                        Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).foregroundStyle(amountColor)
                    }}
                
                Section("Amount Per Person"){
                    Text(totalPerPerson,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
            }.navigationTitle("Wesplit")
        }
    }
}

#Preview {
    ContentView()
}
