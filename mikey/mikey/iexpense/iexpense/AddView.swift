//
//  AddView.swift
//  iexpense
//
//  Created by kalyan on 2/5/26.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "personal"
    @State private var amount = 0.0
    
    @Environment(\.dismiss) var dismiss
    
    var expenses:Expenses
    
    var types = ["personal","business"]
    var body: some View {
        NavigationStack{
            Form{
                TextField("please enter your name" ,text: $name)
                
                Picker("Please select your type??",selection: $type){
                    ForEach(types, id: \.self){
                        Text("\($0)").labelsHidden()
                    }
                }
                
                TextField("amount", value: $amount,format: .currency(code: Locale.current.currency? .identifier ?? "USD"))
                
                
                    .navigationTitle("ADD NEW EXPENSE")
                    .toolbar{
                        Button("SAVE"){
                            let item = ExpenseItem(name: name, type: type, amount: amount)
                            expenses.items.append(item)
                            dismiss()
                        }
                    }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
