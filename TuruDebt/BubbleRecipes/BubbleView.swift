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
                    let _ = print("bubbleScene: \(bubbleScene.children.count)")
                    createScene()
                }
            }
            .onDisappear {
                updateBubble()
            }
    }
    
//    func normalizeSize(val, min, max){
//        return (val - min) / (max - min)
//    }
    
    // MARK: Update data dari coredata
    // MARK: Masukin datanya ke dalam variable array datas
    func updateBubble() {
        datas.removeAll()
        
        for person in persons {
            datas.append(DataItem(title: person.name ?? "no name", size: 81, color: person.totalDebt < 0 ? Color(hex:0xFF7090) : Color(hex:0x8FCBFF)))
        }
        
        let _ = print("datas: \(datas)")
        
//        datas = [
//            DataItem(title: "Sahmad", size: 81, color: .blue),
//            DataItem(title: "Sahmad", size: 81, color: .blue),
//            DataItem(title: "Sahmad", size: 81, color: .blue),
//            DataItem(title: "Sahmad", size: 81, color: .blue),
//        ]
        var iteration = 0
        for data in datas {
            bubbleScene.updateChild(BubbleNode.instantiate(data: data), iteration: iteration)
            
            iteration += 1
            let _ = print(" \(bubbleScene)")
        }

    }
    
    func createScene() {
        bubbleScene.topOffset = CGFloat(-275)
        bubbleScene.onTap = { value in
            selectedName = value
        }
        
//        for person in persons {
//            datas.append(DataItem(title: person.name ?? "no name", size: 81, color: .blue))
//        }
        
        for data in datas {
            bubbleScene.addChild(BubbleNode.instantiate(data: data))
            let _ = print(" \(data)")
        }
        
        let scene = bubbleScene
        
        scene.size = CGSize(width: 300, height: 550)
        scene.scaleMode = .aspectFill
    }
}
