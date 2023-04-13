//
//  SettleDebt.swift
//  TuruDebt1
//
//  Created by Raja Monica on 10/04/23.
//

import SwiftUI

struct SettleDebt: View {
    @State  var nominalBayar: String = ""
    @State  var catatanBayar: String = ""
   // @State  var isAlert = false
    @State  var selectedStatus = ""
    @Binding var showSettleDebt : Bool
    
    var status = ["I Owe You", "You Owe Me"]
    
    var body: some View {
       // NavigationView{
            ZStack{
                VStack{
                    Image("Brazuca Browsing")
                        .padding(.init(top: 0, leading: 150, bottom: 250, trailing: 0))
                        
                }
                
                VStack{
                
                VStack{
                    Button(action: {
                        showSettleDebt.toggle()
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
                            .font(.largeTitle)
                            .padding(.init(top: 0, leading: 340, bottom: 0, trailing: 0))
                    })

                        VStack(alignment: .leading){
                            Text("Gretchen Mango")
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            Text("Enter Nominal")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.gray)
                            TextField("", text: $nominalBayar)
                                .textFieldStyle(.roundedBorder)
                            //.padding()
                                .shadow(radius: 3)
                            
                                .disableAutocorrection(true)
                            
                            // .border(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921), width: 2)
                            
                            Text("Enter Your Note")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.gray)
                            TextField("", text: $catatanBayar)
                                .textFieldStyle(.roundedBorder)
                                .shadow(radius: 3)
                            Picker("Please choose a status", selection: $selectedStatus) {
                                ForEach(status, id: \.self) {
                                    Text($0)
//                            HStack{
//                                Text("What u wanna do?")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(Color.gray)
//                                
//                                
//                                            .padding()
//                                    }
                                }
                                // Text("\(selectedStatus)")
                            }
                            Spacer()
                            Spacer()
                        }
                        .padding()
                        // .padding(.trailing, 250.0)
                        Spacer()
                        VStack{
                            Button(action:  {
                                
                                print("\(nominalBayar)\(catatanBayar)")
                                //  self.isAlert = true
                                showSettleDebt.toggle()
                            }){
                                
                                HStack{
                                    Image(systemName: "paperplane.fill")
                                    
                                    Text("Settle")
                                        .fontWeight(.semibold)
                                    
                                }
                                
                                .foregroundColor(.white)
                                .frame(maxWidth: 100, maxHeight: 50)
                                .background(RoundedRectangle(cornerRadius: 12).fill(LinearGradient(gradient: Gradient(colors: [(Color(red:0.933, green:0.475,blue:0.569)),(Color(red:0.612,green:0.788,blue:0.980))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                                                                   ))
                              
                                
                                //                        .alert(isPresented: $isAlert){
                                //
                                //                            () -> Alert in Alert(title: Text("Pembayaran Sukses"), message: Text("Nominal: \(nominalBayar) \nCatatan: \(catatanBayar) \nStatus: \(selectedStatus)"), dismissButton: .default(Text("OK"), action: {}))}
                                
                                
                            }
                        }
                        
                        .padding(.all)
                        .navigationTitle("")
                        .disabled(nominalBayar.isEmpty || catatanBayar.isEmpty || selectedStatus.isEmpty)
                        
                        
                    
                    }
                    
                }
            }
            
      //  }
    }
}
//struct SettleDebt_Previews: PreviewProvider {
//    static var previews: some View {
//        SettleDebt()
//    }
//}
