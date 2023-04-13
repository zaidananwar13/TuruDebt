//
//  Home_View.swift
//  TuruDebt1
//
//  Created by Raja Monica on 09/04/23.
//

import SwiftUI

struct Home_View: View {
    @State var showNewTransactionScreen: Bool = false
    @State var showPopupIOY: Bool = false
    //@State var showHome: Bool = false
    
    
    var body: some View {
        NavigationView{
        ZStack{
            VStack{
                VStack{
                    HStack{
                        Text("Navigate Your")
                        Text("Debt")
                            .foregroundColor(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
                        Text("Transaction Easily")
                        
                        
                    }
                    .bold()
                    .font(.title3)
                    .padding()
                    
                    Spacer()
                    
                    HStack{
                        Text("Tap once")
                            .foregroundColor(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
                        Text("on the bubble to see nominal")
                        
                    }
                    .bold()
                    //  .padding(.bottom, 600.0)
                    Spacer()
                    
                    HStack{
                        Text("Tap twice")
                            .foregroundColor(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
                        Text("to expand the detail")
                    }
                    .bold()
                    Spacer()
                }
                .frame(height: 100)
                Spacer()
                
                ZStack{
                    Circle()
                    
                        .fill(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
                        .frame(width: 200, height: 200)
                        .padding()
                    //                Text("Gretchen M")
                    //                    .font(.title)
                    //                    .fontWeight(.semibold)
                    //                    .foregroundColor(.white)
                    //                    .padding()
                    
                    Button(action: {
                        //presentationMode.wrappedValue.dismiss()
                        showPopupIOY.toggle()
                    },label: {
                        Text("Gretchen")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(10)
                    })
                    
                }
                Spacer()
                
                Button(action: {
                    //presentationMode.wrappedValue.dismiss()
                    showNewTransactionScreen.toggle()
                },label: {
                    Image(systemName: "chevron.compact.up")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(10)
                })
                HStack{
                    Text("Slide")
                        .foregroundColor(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
                    Text("to Add New Transaction")
                }
                
            }
            //        .sheet(isPresented: $showPopupIOY) {
            //            popupIOY(showPopupIOY: $showPopupIOY)
            //        }
            //        .presentationDetents([.medium])
            
            
            //        .popover(isPresented: $showPopupIOY) {
            //                Text("Your content here")
            //                   .font(.headline)
            //                   .padding()
            //           }
            
            
            //            if showPopupIOY{
            //                popupIOY(showPopupIOY: $showPopupIOY)
            //                    .padding()
            //                    .frame(width: 300, height: 300)
            //                    .transition(.identity)
            //                    .animation(.easeOut(duration: 1.0))
            //
            //
            //            }
            
            //            popupIOY(showPopupIOY: $showPopupIOY)
            //                .padding(.top,200)
            //            offset(y: showPopupIOY ? 0 : UIScreen.main.bounds.height)
            //                .animation(.spring())
            
            //slide new transaction
            //            if showNewTransactionScreen{
            //                NewTransactionScreen(showNewTransactionScreen: $showNewTransactionScreen)
            ////                    .padding()
            ////                    .frame()
            //                    .transition(.move(edge: .bottom))
            //                    .animation(.spring())
            //            }
            .sheet(isPresented: $showNewTransactionScreen) {
                NewTransactionScreen(showNewTransactionScreen: $showNewTransactionScreen)
                
            }
            
            .presentationDetents([.large])
            
            
        }
            
    }
    }
}

struct NewTransactionScreen: View{
    @Environment(\.presentationMode) var presentationMode
    @Binding var showNewTransactionScreen: Bool
   // @Binding var showHome : Bool
    
    @State  var username: String = ""
    @State  var nominalBayar: String = ""
    @State  var catatanBayar: String = ""
    @State var selectedStatus = ""
    var status = ["I Owe You", "You Owe Me"]
    var body: some View{
        VStack{
            ZStack{
                Color.white

                    .edgesIgnoringSafeArea(.all)
                VStack{
                    HStack{
                        Text("Slide")
                            .foregroundColor(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
                        
                        //.fill(LinearGradient(gradient: Gradient(colors: [(Color(red:0.933, green:0.475,blue:0.569)),(Color(red:0.612,green:0.788,blue:0.980))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        
                        
                        Text("to back to Home")
                    }
                    
                    Button(action: {
                        //presentationMode.wrappedValue.dismiss()
                        showNewTransactionScreen.toggle()
                    },label: {
                        Image(systemName: "chevron.compact.down")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                           .padding(2)
                        
                    })
                    
                    
                    VStack{
                        HStack{
                            Text("Fill")
                                 .foregroundColor(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
                            Text("the Form")
                                
                                
                                
                        }
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    }
                    VStack(alignment: .leading){
                        Text("Enter Username")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.gray)
                        TextField("", text: $username)
                            .textFieldStyle(.roundedBorder)
                            .shadow(radius: 2)
                        Text("Enter Nominal")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.gray)
                        TextField("", text: $nominalBayar)
                            .textFieldStyle(.roundedBorder)
                            .shadow(radius: 2)
                        Text("Enter Notes")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.gray)
                        TextField("", text: $catatanBayar)
                            .textFieldStyle(.roundedBorder)
                            .shadow(radius: 2)
                        Text("What are You?")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.gray)
                        Picker("Please choose a status", selection: $selectedStatus) {
                            ForEach(status, id: \.self) {
                                Text($0)
                                    .padding()
                            }
                        }
                       
                    }
                    .padding()
                    Spacer()
                    
                    //button
                    VStack{
                        Button(action:  {
                            
                            print("\(nominalBayar)\(catatanBayar)")
                          //  self.isAlert = true
                            showNewTransactionScreen.toggle()
//                            LinearGradient(colors: [.pink, .blue]
//                                           , startPoint: .top, endPoint: .bottom)
                        }){
                            
                            HStack{
                                Image(systemName: "paperplane.fill")
                                
                                Text("Save")
                                    .fontWeight(.semibold)
                                
                            }
                            
                            .foregroundColor(.white)
                            .frame(maxWidth: 100, maxHeight: 50)
                            .background(RoundedRectangle(cornerRadius: 12)
                                .fill(LinearGradient(gradient: Gradient(colors: [(Color(red:0.933, green:0.475,blue:0.569)),(Color(red:0.612,green:0.788,blue:0.980))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                            )
                                
                           
                            
                        }
                    }
                    .navigationTitle("")
                    .disabled(username.isEmpty||nominalBayar.isEmpty || catatanBayar.isEmpty || selectedStatus.isEmpty)
                }
                
       //tutup zstack1
            }
      //tutup Vstack
        }
    }
}
            
//struct popupIOY: View{
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var showPopupIOY: Bool
//
//    var body: some View{
//        VStack{
//            VStack{
//                ZStack(alignment: .topTrailing){
//
//                    Color.blue
//                        .edgesIgnoringSafeArea(.all)
//                        .padding()
//                        .frame(width: 350, height: 350)
//
//                    Button(action: {
//                        showPopupIOY.toggle()
//                    }, label: {
//                        Image(systemName: "xmark")
//                            .foregroundColor(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
//                            .font(.title)
//                            .padding(.init(top: 25, leading: 0, bottom: 0, trailing: 25))
//                    })
//
//
//
//                }
//
//            }
//        }
//
//    }
//}

struct Home_View_Previews: PreviewProvider {
    static var previews: some View {
        Home_View()
    }
}

//// struct ContentView: View {
//@State private var showingPopover = false
//
//var body: some View {
//    Button("Show Menu") {
//        showingPopover = true
//    }
//    .popover(isPresented: $showingPopover) {
//        Text("Your content here")
//            .font(.headline)
//            .padding()
//    }
//}
//}
