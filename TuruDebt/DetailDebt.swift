//
//  DetailDebt.swift
//  TuruDebt1
//
//  Created by Raja Monica on 10/04/23.
//

import SwiftUI

struct DetailDebt: View {
    @State var showSettleDebt: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                Text("I Owe You")
                    .font(.largeTitle)
                    .foregroundColor(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
                    .fontWeight(.bold)
                    .padding()
                Text("Gretchen Mango")
                    .font(.title2)
                    .fontWeight(.semibold)
                ZStack{
                    Circle()
                        .fill(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921).opacity(0.6))
                        .frame(width: 150, height: 150)
                    Circle()
                        .fill(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
                        .frame(width: 100, height: 100)
                    Image(systemName: "creditcard.circle.fill")
                        .resizable(resizingMode: .stretch)
                        .foregroundColor(Color.white)
                        .frame(width: 60.0, height: 60.0)
                        
                }
                VStack{
                    Text("Rp.100.000")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Button(action: { showSettleDebt = true })
                     {
                        HStack{
                            Image(systemName: "paperplane.fill")
                            Text("Settle Your Debt")
                                .fontWeight(.semibold)
                                
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth:250,maxHeight: 60)
                        .padding(.trailing, 20)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921)))
                        .navigationTitle("Debt Detail")
                        
                    }
//                    NavigationLink("", destination:  SettleDebt(showSettleDebt: $showSettleDebt), isActive: $showSettleDebt)
                    
                        .sheet(isPresented: $showSettleDebt) {
                            SettleDebt(showSettleDebt: $showSettleDebt)
                                .presentationDetents([.fraction(0.70)])
                    }
                   //Spacer()
                }
               Spacer()
                VStack{
                    Text("Debt History")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.trailing,230)
                    VStack{
                        Text("Friday, April 07, 2023")
                            .fontWeight(.semibold)
                            .padding(.init(top: 3, leading: 0, bottom: 0, trailing: 185))
                        HStack{
                            Image(systemName: "creditcard.circle.fill")
                                .resizable(resizingMode: .stretch)
                                .foregroundColor(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
                                .frame(width: 30.0, height: 30.0)
                                .padding()
                            //Spacer()
                            Text("Cinema Ticket")
                            Spacer()
                            Text("-Rp.100.000")
                            Spacer()
                        }
                    }
                    VStack{
                        Text("Saturday, April 08, 2023")
                            .fontWeight(.semibold)
                            .padding(.init(top: 3, leading: 0, bottom: 0, trailing: 155))
                        HStack{
                            Image(systemName: "creditcard.circle.fill")
                                .resizable(resizingMode: .stretch)
                                .foregroundColor(Color.blue).opacity(0.4)
                                .frame(width: 30.0, height: 30.0)
                                .padding()
                            Spacer()
                            Text("Cicil dulu")
                            Spacer()
                            Text("Rp.25.000")
                            Spacer()
                            
                            
                        }
                      //  Spacer()
                    
                    }
                    
                }
                
                
            }
            
        }
    }
}

struct DetailDebt_Previews: PreviewProvider {
    static var previews: some View {
        DetailDebt()
    }
}
