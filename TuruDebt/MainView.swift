//
//  ContentView.swift
//  TuruDebt
//
//  Created by Zaidan Anwar on 31/03/23.
//

import SwiftUI
import SpriteKit

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}


struct MainView: View {
    @State private var selectedName: String = ""
    @State private var onChangeView: Bool = false
    @State private var data: [DataItem] = [
        DataItem(title: "Ahmad", size: 81, color: .blue),
        DataItem(title: "Bagas", size: 61, color: .blue),
        DataItem(title: "Cika", size: 81, color: .blue),
        DataItem(title: "Florence", size: 50, color: .blue),
        DataItem(title: "Gugus", size: 51, color: .blue),
        DataItem(title: "Hijrul", size: 60, color: .blue),
        DataItem(title: "Ica", size: 90, color: .blue),
    ]
    
    @State var bubbleScene: BubblesScene = BubblesScene()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("Navigate Your Debt Transaction Easily")
                        .padding(3)
                        .fontWeight(.medium)
                    Text("Tap once on the bubble you like to see the nominal, or twice to expand the  detail")
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                }.padding()
                
                SpriteView(scene: bubbleScene)
                    .onChange(of: selectedName) { newValue in
                        onChangeView = true
                        
                    }
                    .onAppear {
                        if bubbleScene.children.count < 1 {
                            createScene()
                        }
                    }
                NavigationLink(
                    destination: TestSwitchPage(onClose: $onChangeView, name: selectedName),
                    isActive: $onChangeView,
                    label: {
                        EmptyView()
                    })
                    .hidden()
                
                Spacer()
                
                Spacer()
                
                VStack {
                    Text("^")
                        .fontWeight(.black)
                    Text("Slide to Add New Transaction")
                        .fontWeight(.medium)
                }
            }
        }
    }
    
    func createScene() {
        bubbleScene = BubblesScene()
        
        bubbleScene.topOffset = CGFloat(-275)
        bubbleScene.onTap = { value in
            selectedName = value
        }
        
        for dt in data {
            bubbleScene.addChild(BubbleNode.instantiate(data: dt))
        }
        
        let scene = bubbleScene
        
        scene.size = CGSize(width: 300, height: 550)
        scene.scaleMode = .aspectFit
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
