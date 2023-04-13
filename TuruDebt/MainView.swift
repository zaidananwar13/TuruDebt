//
//  ContentView.swift
//  TuruDebt
//
//  Created by Zaidan Anwar on 31/03/23.
//

import SwiftUI

struct MainView: View {
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
                    FirstTimeView(firstTimer: $firstTime)
                        .onAppear {
                            firstTime = false
                        }
                        .navigationDestination(
                            isPresented: $firstTime) {
                                NewTransactionView()
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
                    
                    BubbleView(onSelectedBubble: $onDetailView, selectedName: $selectedName, datas: $data)
                        .navigationDestination(
                            isPresented: $onDetailView) {
                                DetailView(penghutang: $selectedName, onClose: $onDetailView)
                                Text("")
                                    .hidden()
                            }
                    
                    Spacer()
                    Spacer()
                    
                    VStack {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
