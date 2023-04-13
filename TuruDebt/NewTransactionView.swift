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
    @State private var utang = false
    
    let defaults = UserDefaults.standard
    
    
    func saveNama(name: String){
        defaults.set(name, forKey: "Nama")
        
    }
    
    
    enum Status: String, CaseIterable, Identifiable {
        case iOweYou, youOweMe
        var id: Self { self }
    }
    
    @State private var selectedStatus: Status = .iOweYou
    
    let gradientColors = [
        Color(hex: 0xFF7090),
        Color(hex: 0x8FCBFF)
    ]
    
    var body: some View {
        VStack {
            VStack{
                VStack{
                    Text("Slide to back to Home")
                        .padding(.bottom,6)
                    Image(systemName: "chevron.down")
                }
                .padding(.bottom,25)
                HStack {
                    Text("Fill")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor( selectedStatus == Status.iOweYou ? Color(hex: 0xFF7090) : Color(hex: 0x8FCBFF))
                    Text("the Form")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .padding(.bottom, 30)
                HStack{
                    Text("Name")
                        .foregroundColor(.gray)
                    Spacer()
                }
                TextField(
                    "Write your name",
                    text: $name
                )
                
                .frame(height: 41)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 4, x: 2, y: 2)
                .padding(.bottom, 24.0)
                
                HStack{
                    Text("Nominal")
                        .foregroundColor(.gray)
                    Spacer()
                }
                TextField(
                    "Nominal transaction",
                    text: $nominal
                )
                .frame(height: 41)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 4, x: 2, y: 2)
                
                .padding(.bottom, 24.0)
                
                HStack{
                    Text("Note")
                        .foregroundColor(.gray)
                    Spacer()
                }
                TextField(
                    "Reason",
                    text: $note
                )
                .frame(height: 41)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 4, x: 2, y: 2)
                .padding(.bottom, 24.0)
                
            }
            .padding(.horizontal)
            
            VStack{
                HStack{
                    Text("What are you?")
                        .foregroundColor(.gray)
                    Spacer()
                }
                HStack{
                    Picker("Status", selection: $selectedStatus) {
                        Text("I Owe You \(name)").tag(Status.iOweYou)
                        Text("You Owe Me \(name)").tag(Status.youOweMe)                       
                    }
                    .accentColor(selectedStatus == Status.iOweYou ? Color(hex: 0xFF7090) : Color(hex: 0x8FCBFF))
                    Spacer()
                }
                
                Spacer()
            }
            
            .padding()
            Text(defaults.string(forKey: "Nama") ?? "")
            Spacer(minLength:10)
            Button(action: {
                print("Clicked")
                saveNama(name:name)
            }, label: {
                HStack {
                    
                    Image(systemName: "paperplane.fill")
                    
                    Text("Save")
                }
            })
            .foregroundColor(.white)
            .background(selectedStatus == Status.iOweYou ? Color(hex: 0xFF7090) : Color(hex: 0x8FCBFF))
            .cornerRadius(5)
            .frame(height:25)
            .padding(0)
            .buttonStyle(.bordered)
        }
    }
}

struct NewTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionView()
    }
}
