//
//  Bulet.swift
//  TuruDebt
//
//  Created by Zaidan Anwar on 06/04/23.
//

import SwiftUI

struct ViewSize {
    var xMin: CGFloat = 0
    var xMax: CGFloat = 0
    var yMin: CGFloat = 0
    var yMax: CGFloat = 0
}

struct Bulet: View {
    @Binding var viewSize: ViewSize
    var item: DataItem
    var scale: Double
    
    @State var ditekan = false
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var offsetValue = CGSize.zero
    
    var body: some View {
        Text("Five stars")
            .frame(width: CGFloat(item.size) * scale, height: CGFloat(item.size) * scale)
            .background(.blue)
            .cornerRadius(100.0)
            .scaleEffect(ditekan ? 1.1 : 1)
            .onTapGesture {
                ditekan.toggle()

                withAnimation(.easeInOut(duration: 0.5)) {
                    
                }
            }
            .offset(x: offsetValue.width, y: offsetValue.height)
            .animation(.default.delay(Double(4) / 25), value: dragAmount)
            .gesture(
                DragGesture()
                    .onChanged {
                        dragAmount = $0.translation
                        offsetValue.width += (dragAmount.width * 0.02)
                        offsetValue.height += (dragAmount.height * 0.02)
                    }
                    .onEnded { _ in
                        enabled.toggle()
                        dragAmount = .zero
                    }
            )
            .onTapGesture {
                ditekan.toggle()
                
            }
            .offset(x: item.offset.width * scale, y: item.offset.height * scale)
    }
}

struct popupIOY: View{
    @Environment(\.presentationMode) var presentationMode
    @Binding var showPopupIOY: Bool
    
    var body: some View{
        VStack{
            VStack{
                ZStack(alignment: .topTrailing){
                    
                    Color.blue
                        .edgesIgnoringSafeArea(.all)
                        .padding()
                        .frame(width: 350, height: 350)
                    
                        Button(action: {
                            showPopupIOY.toggle()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color(red: 0.9607843137254902, green: 0.4745098039215686, blue: 0.5686274509803921))
                                .font(.title)
                                .padding(.init(top: 25, leading: 0, bottom: 0, trailing: 25))
                        })
                    
                    
                
                }
                
            }
        }
    }
}
