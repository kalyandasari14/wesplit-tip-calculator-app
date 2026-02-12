//
//  ContentView.swift
//  iexpense
//
//  Created by kalyan on 2/4/26.
//

import SwiftUI

// we are crating a new struct where we storing new variables in this expenseitem struct
struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
// we are creating a class where we assign the items variable to expense class struct and converting into it an array

class Expenses{
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "items"){
            if let decodedItems = try?  JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
    
}

struct ContentView:View {
    // we are intialising a state property and assigning it to expenses class
    @State private var expenses = Expenses()
    @State private var showingView = false
    var body: some View {
        NavigationStack{
            VStack{
                // we are creating a list wherer each item that we append from expenses items we are trying to make it in alist as a seperate property
                List{
                    ForEach(expenses.items){item in
                        Text(item.name)
                        Text(item.type)
                        Text("\(item.amount)").foregroundStyle(color(for: item.amount))
                    }.onDelete(perform: remove)
                }
            }.navigationTitle("iExpense")
                .toolbar(){
                    // we are creating a button
                    Button("addme", systemImage: "plus"){
                       showingView = true
                    }
                }
        }.sheet(isPresented: $showingView){
            AddView(expenses: expenses)
        }
    }
    func remove(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
    func color(for amount : Double) ->Color{
        if amount <= 10{
            return.green}
        else if amount < 100{
            return .yellow
        }else{
            return.red
        }
    }
}

#Preview {
    ContentView().tint(.purple)
}
