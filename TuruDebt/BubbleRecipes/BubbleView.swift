//
//  BubbleView.swift
//  TuruDebt
//
//  Created by Zaidan Anwar on 13/04/23.
//

import SwiftUI
import SpriteKit

struct BubbleView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Person.name, ascending: false)], animation: .default)
    private var persons: FetchedResults<Person>
    
    @Binding var onFirstTimeView: Bool
    @Binding var onSelectedBubble: Bool
    @Binding var selectedName: String
    @State var datas: [DataItem]
    @State var bubbleScene: BubblesScene = BubblesScene()
    @State private var onNewTransactionView: Bool = false
    
    var body: some View {
        if persons.count < 1 {
            FirstTimeView(firstTimer: $onFirstTimeView)
                .onAppear {
                    onFirstTimeView = false
                }
                .navigationDestination(
                    isPresented: $onFirstTimeView) {
                        NewTransactionView().navigationBarBackButtonHidden(true)
                        Text("")
                            .hidden()
                    }
        }else {
            VStack {
                HStack {
                    Text("Navigate Your Debt Transaction")
                    Text("Easily")
                        .foregroundColor(.pink)
                }
                .padding(3)
                .fontWeight(.medium)
                
                HStack {
                    Text("Tap twice")
                        .foregroundColor(.pink)
                    Text("to expand the detail")
                }
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                
            }.padding()
            
            SpriteView(scene: bubbleScene)
                .onChange(of: selectedName) { newValue in
                    onSelectedBubble = true
                }
                .onAppear {
                    onFirstTimeView = true
                    if bubbleScene.children.count < 1 {
                        createScene()
                    }else {
                        updateBubble()
                    }
                }
                .onDisappear {
                    updateBubble()
                }
            
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
    
    func map(minRange:Double, maxRange:Double, minDomain:Double, maxDomain:Double, value:Double) -> Double {
        return minDomain + (maxDomain - minDomain) * (value - minRange) / (maxRange - minRange)
    }
    
    func normalizeSize(x: Double, min: Double, max:Double) -> Double{
        return map(minRange: abs(min), maxRange: abs(max), minDomain: 50, maxDomain: 150, value: abs(x))
    }
    
    // MARK: Update data dari coredata
    // MARK: Masukin datanya ke dalam variable array datas
    func updateBubble() {
        let maxx = persons.map { $0.totalDebt }.max()
        let minx = persons.map { $0.totalDebt }.min()
        let status = datas.count > 0 ? true : false
        
        datas.removeAll()

        for person in persons {
            if person.totalDebt != 0 {
                    datas.append(DataItem(title: person.name ?? "no name", size: normalizeSize(x: person.totalDebt, min: minx!, max: maxx!), color: person.totalDebt < 0 ? Color(hex:0xFF7090) : Color(hex:0x8FCBFF)))
            }
        }
        
        var iteration = 0
        for data in datas {
            bubbleScene.updateChild(BubbleNode.instantiate(data: data), iteration: iteration, status: status)
            iteration += 1
        }
    }
    
    func createScene() {
        datas = []
        
        bubbleScene.topOffset = CGFloat(-275)
        bubbleScene.onTap = { value in
            selectedName = value
        }
        
        let scene = bubbleScene
        
        scene.size = CGSize(width: 300, height: 550)
        scene.scaleMode = .aspectFill
        
        updateBubble()
    }
}
