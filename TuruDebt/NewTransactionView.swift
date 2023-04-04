//
//  NewTransactionView.swift
//  screen transaction turu app
//
//  Created by Pahala Sihombing on 03/04/23.
//

import SwiftUI



struct NewTransactionView: View {
    @State private var name: String = ""
    @State private var nominal: String = ""
    @State private var note: String = ""
    
    enum Status: String, CaseIterable, Identifiable {
        case youOweMe, iOweYou
        var id: Self { self }
    }
    
    @State private var selectedStatus: Status = .youOweMe
    
    var body: some View {
        VStack {
            VStack{
                VStack{
                    Text("Swipe down to close")
                    Image(systemName: "chevron.compact.down")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                }
                HStack{
                    Text("Name")
                    Spacer()
                }
                TextField(
                    "Write your name",
                    text: $name
                )
                .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .cornerRadius(5)
                .background(Color(hex: 0xD9D9D9, alpha: 1))
                
                HStack{
                    Text("Nominal")
                    Spacer()
                }
                TextField(
                    "Nominal transaction",
                    text: $nominal
                )
                .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .cornerRadius(5)
                .background(Color(hex: 0xD9D9D9, alpha: 1))
                
                HStack{
                    Text("Note")
                    Spacer()
                }
                TextField(
                    "Reason",
                    text: $note
                )
                .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .cornerRadius(5)
                .background(Color(hex: 0xD9D9D9, alpha: 1))
                
            }
            .padding(.horizontal)
            
            
            Picker("Status", selection: $selectedStatus) {
                Text("You Owe Me \(name)")
                Text("I Owe You \(name)")
            }
            
            Spacer()
            
            Button(action: {
                print("Clicked")
            }, label: {
                HStack {
                   
                    Image(systemName: "paperplane.fill")
                    
                    Text("Save")
                }
            })
            .foregroundColor(.white)
            .cornerRadius(5)
            .frame(height:55)
            .padding(0)
            .buttonStyle(.borderedProminent)
        }
    }
}

struct NewTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionView()
    }
}
