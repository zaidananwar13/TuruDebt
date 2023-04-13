//
//  SettleDebt.swift
//  TuruDebt1
//
//  Created by Raja Monica on 10/04/23.
//

import SwiftUI

struct SettleDebt: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var person: Person
    
    @State var nominal: String = ""
    @State var note: String = ""
    @State var showSettleDebt : Bool =  false
    
    enum Status: String, CaseIterable, Identifiable {
        case pay, addMore
        var id: Self { self }
    }
    @State private var settleSelectedStatus: Status = .pay
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Button(action: {
                        showSettleDebt.toggle()
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
                            .font(.largeTitle)
                            .padding(.init(top: 0, leading: 310, bottom: 0, trailing: 0))
                    })
                }
                
                HStack{
                    Text("\(person.name!)")
                        .foregroundColor(settleSelectedStatus == Status.pay ? Color(hex: 0xFF7090) : Color(hex: 0x8FCBFF))
                    Spacer()
                }
                .padding(.bottom)
                
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
                .keyboardType(.numberPad)
                
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
                
                VStack{
                    HStack{
                        Text("What are you?")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack{
                        Picker("Status", selection: $settleSelectedStatus) {
                            Text("Pay").tag(Status.pay)
                            Text("Add more").tag(Status.addMore)
                        }
                        .accentColor(settleSelectedStatus == Status.pay ? Color(hex: 0xFF7090) : Color(hex: 0x8FCBFF))
                        Spacer()
                    }
                }
                .padding()
                
                Button(action: {
                    print("Clicked")
                    //                addPerson()
                    dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "paperplane.fill")
                        Text("Settle")
                    }
                })
                .foregroundColor(.white)
                .background(settleSelectedStatus == Status.pay ? Color(hex: 0xFF7090) : Color(hex: 0x8FCBFF))
                .cornerRadius(5)
                .frame(height:25)
                .padding(0)
                .buttonStyle(.bordered)
            }
            .padding(.horizontal)
            
            
        }
    }
}
//struct SettleDebt_Previews: PreviewProvider {
//    static var previews: some View {
//        SettleDebt()
//    }
//}
