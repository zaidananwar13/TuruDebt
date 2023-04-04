//
//  ContentView.swift
//  screen transaction turu app
//
//  Created by Pahala Sihombing on 31/03/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack{
                Text("Gretchen Mango")
                    .font(.title)
                    .fontWeight(.bold)
                    Spacer()
            }
            .padding(.horizontal)
            ZStack {
                Circle()
                    .padding(.horizontal, 70.0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.96, green: 0.475, blue: 0.569)/*@END_MENU_TOKEN@*/)
                Text("Rp. 100.000")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            HStack{
                Text("Recent Transaction")
                    .fontWeight(.medium)
                Spacer()
                Button(action: {
                    print("Clicked")
                }, label: {
                    HStack {
                        Image(systemName: "paperplane.fill")
                        Text("Add")
                    }
                })
                .foregroundColor(.white)
                .background(/*@START_MENU_TOKEN@*/Color(red: 0.96, green: 0.475, blue: 0.569)/*@END_MENU_TOKEN@*/)
                .cornerRadius(5)
                .frame(height:55)
                .padding(0)
                .buttonStyle(.bordered)
            }
            .padding(.horizontal)
            List {
                yudaView()
                yudaView()
                yudaView()
                yudaView()
                
            }
            .frame(maxWidth: .infinity)
            .listStyle(.inset)
            .scrollContentBackground(.hidden)
            
        }
    }
}


struct yudaView: View {
    var body: some View {
        VStack {
            HStack{
                VStack{
                    Text("Ayam Bakar Aldo")
                        .fontWeight(.medium)
                    Text("23 March 2023")
                        .opacity(0.3)
                }
                Spacer()
                Text("+Rp 25.000")
                    .fontWeight(.semibold)

            }
            .padding(20)
        }
        .background(Color(hex: 0xA39E9E, alpha: 0.25))
        .cornerRadius(10.0)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
