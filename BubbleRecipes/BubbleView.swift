//
//  BubbleView.swift
//  TuruDebt
//
//  Created by Zaidan Anwar on 13/04/23.
//

import SwiftUI
import SpriteKit

struct BubbleView: View {
    @Binding var onSelectedBubble: Bool
    @Binding var selectedName: String
    @Binding var datas: [DataItem]
    @State var bubbleScene: BubblesScene = BubblesScene()
    
    var body: some View {
        SpriteView(scene: bubbleScene)
            .onChange(of: selectedName) { newValue in
                onSelectedBubble = true
            }
            .onAppear {
                if bubbleScene.children.count < 1 {
                    createScene()
                }
            }
            .onDisappear {
                updateBubble()
            }
    }
    
    // MARK: Update data dari coredata
    // MARK: Masukin datanya ke dalam variable array datas
    func updateBubble() {

        datas = [
            DataItem(title: "Sahmad", size: 81, color: .blue),
            DataItem(title: "Sahmad", size: 81, color: .blue),
            DataItem(title: "Sahmad", size: 81, color: .blue),
            DataItem(title: "Sahmad", size: 81, color: .blue),
        ]
        
        var iteration = 0
        for data in datas {
            bubbleScene.updateChild(BubbleNode.instantiate(data: data), iteration: iteration)
            
            iteration += 1
        }
    
    }
    
    func createScene() {
        bubbleScene.topOffset = CGFloat(-275)
        bubbleScene.onTap = { value in
            selectedName = value
        }
        
        for data in datas {
            bubbleScene.addChild(BubbleNode.instantiate(data: data))
        }
        
        let scene = bubbleScene
        
        scene.size = CGSize(width: 300, height: 550)
        scene.scaleMode = .aspectFit
    }
}
