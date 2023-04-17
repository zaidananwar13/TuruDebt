//
//  ContentView.swift
//  TuruDebt
//
//  Created by Zaidan Anwar on 31/03/23.
//

import SwiftUI

struct DataItem: Identifiable {
    var id = UUID()
    var title: String
    var size: CGFloat
    var color: Color
    var offset = CGSize.zero
}

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Person.name, ascending: false)], animation: .default)
    private var persons: FetchedResults<Person>
//
    @State private var firstTime: Bool = false
    @State private var selectedName: String = ""
    @State private var onDetailView: Bool = false
    @State private var onNewTransactionView: Bool = false
    
    @State private var data: [DataItem] = [
        DataItem(title: "Ahmad", size: 81, color: .blue),
        DataItem(title: "Bagas", size: 61, color: .blue),
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                if data.count < 1 {
                    //                    let _ = print(saveDataitem().count)
                    FirstTimeView(firstTimer: $firstTime)
                        .onAppear {
                            firstTime = false
                        }
                        .navigationDestination(
                            isPresented: $firstTime) {
                                NewTransactionView().navigationBarBackButtonHidden(true)
                                Text("")
                                    .hidden()
                            }
                    
                }else {
                    VStack {
                        Text("Navigate Your Debt Transaction Easily")
                            .padding(3)
                            .fontWeight(.medium)
                        Text("Tap twice to expand the detail")
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                    }.padding()
                    //
                    BubbleView(onSelectedBubble: $onDetailView, selectedName: $selectedName, datas: data)
                        .navigationDestination(
                            isPresented: $onDetailView) {
                                //                                    ForEach(persons) { person in
                                //                                        DetailTransactionView(person: person)
                                //                                        //                                onDetailView.toggle()
                                DetailView(targetPerson: $selectedName, onClose: $onDetailView)
                                //
                                //                                    }
                                Text("")
                                    .hidden()
                                //
                            }
                    
                    Spacer()
                    
                    VStack {
//                        Button(action: {
//                            print("Clicked")
//                            addPerson()
//
//                        }, label: {
//                            HStack {
//                                Image(systemName: "paperplane.fill")
//                                Text("Save")
//                            }
//                        })
//                        .foregroundColor(.white)
//                        .padding()
//                        .cornerRadius(15)
//                        .buttonStyle(.bordered)
//                        .background(
//                            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x8FCBFF), Color(hex: 0xFF7090)]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                        )
//
                            
                        Text("^")
                            .fontWeight(.black)
                        Text("Slide to Add New Transaction")
                            .fontWeight(.medium)
                    }
                    .navigationDestination(
                        isPresented: $onNewTransactionView) {
                            NewTransactionView()
                            Text("")
                                .hidden()
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { drag in
                                    if drag.location.y < -60 {
                                        onNewTransactionView = true
                                    }
                                }
                        )
                }
            }
        }
    }
    
    func saveDataitem () -> [DataItem] {
        for person in persons {
            data.append(DataItem(title: person.name!, size: 81, color: person.totalDebt < 0 ? Color(hex:0xFF7090) : Color(hex:0x8FCBFF)))
            let _ = print("person: \(persons.count)")
            let _ = print("data: \(data)")
        }

        return data
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainViewX()
//    }
//}
