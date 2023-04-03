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

struct BubbleView: View {
    
    @Binding var data: [DataItem]
    
    // Spacing between bubbles
    var spacing: CGFloat
    
    // startAngle in degrees -360 to 360 from left horizontal
    var startAngle: Int
    
    // direction
    var clockwise: Bool
    
    struct ViewSize {
        var xMin: CGFloat = 0
        var xMax: CGFloat = 0
        var yMin: CGFloat = 0
        var yMax: CGFloat = 0
    }
    
    @State private var mySize = ViewSize()
    
    @GestureState var isLongPressed = false
    @State private var offset:CGSize = .zero
    
    
    var body: some View {
        
        let longPressedGesture = LongPressGesture()
            .updating($isLongPressed){
                newValue, state, transaction in
                state = newValue
            }
        
        
        let xSize = (mySize.xMax - mySize.xMin) == 0 ? 1 : (mySize.xMax - mySize.xMin)
        let ySize = (mySize.yMax - mySize.yMin) == 0 ? 1 : (mySize.yMax - mySize.yMin)

        GeometryReader { geo in
            
            let xScale = geo.size.width / xSize
            let yScale = geo.size.height / ySize
            let scale = min(xScale, yScale)
            
            
                     
            ZStack {
//                ForEach(data, id: \.id) { item in
//                    ZStack {
//                        Circle()
//                            .frame(width: CGFloat(item.size) * scale,
//                                   height: CGFloat(item.size) * scale)
//                            .foregroundColor(item.color)
//                            .scaleEffect(isLongPressed ? 2 : 1)
//                            .animation(.default, value: offset)
//                        Text(item.title)
//                    }
//                    .animation(.easeOut, value: 0.3)
//                    .gesture(longPressedGesture)
//                    .offset(x: item.offset.width * scale, y: item.offset.height * scale)
//
//                }
            }
            .offset(x: xOffset() * scale, y: yOffset() * scale)
        }
        .onAppear {
            setOffets()
            mySize = absoluteSize()
        }
    }
    
    
    // taken out of main for compiler complexity issue
    func xOffset() -> CGFloat {
        let size = data[0].size
        let xOffset = mySize.xMin + size / 2
        return -xOffset
    }
    
    func yOffset() -> CGFloat {
        let size = data[0].size
        let yOffset = mySize.yMin + size / 2
        return -yOffset
    }

    
    // calculate and set the offsets
    func setOffets() {
        if data.isEmpty { return }
        // first circle
        data[0].offset = CGSize.zero
        
        if data.count < 2 { return }
        // second circle
        let b = (data[0].size + data[1].size) / 2 + spacing
        
        // start Angle
        var alpha: CGFloat = CGFloat(startAngle) / 180 * CGFloat.pi
        
        data[1].offset = CGSize(width:  cos(alpha) * b,
                                height: sin(alpha) * b)
        
        // other circles
        for i in 2..<data.count {
            
            // sides of the triangle from circle center points
            let c = (data[0].size + data[i-1].size) / 2 + spacing
            let b = (data[0].size + data[i].size) / 2 + spacing
            let a = (data[i-1].size + data[i].size) / 2 + spacing
            
            alpha += calculateAlpha(a, b, c) * (clockwise ? 1 : -1)
            
            let x = cos(alpha) * b
            let y = sin(alpha) * b
            
            data[i].offset = CGSize(width: x, height: y )
        }
    }
    
    // Calculate alpha from sides - 1. Cosine theorem
    func calculateAlpha(_ a: CGFloat, _ b: CGFloat, _ c: CGFloat) -> CGFloat {
        return acos(
            ( pow(a, 2) - pow(b, 2) - pow(c, 2) )
            /
            ( -2 * b * c ) )
        
    }
    
    // calculate max dimensions of offset view
    func absoluteSize() -> ViewSize {
        let radius = data[0].size / 2
        let initialSize = ViewSize(xMin: -radius, xMax: radius, yMin: -radius, yMax: radius)
        
        let maxSize = data.reduce(initialSize, { partialResult, item in
            let xMin = min(
                partialResult.xMin,
                item.offset.width - item.size / 2 - spacing
            )
            let xMax = max(
                partialResult.xMax,
                item.offset.width + item.size / 2 + spacing
            )
            let yMin = min(
                partialResult.yMin,
                item.offset.height - item.size / 2 - spacing
            )
            let yMax = max(
                partialResult.yMax,
                item.offset.height + item.size / 2 + spacing
            )
            return ViewSize(xMin: xMin, xMax: xMax, yMin: yMin, yMax: yMax)
        })
        return maxSize
    }
    
}

struct MainView: View {
    @State private var data: [DataItem] = [
            DataItem(title: "chrome", size: 10, color: .blue),
        ]
    
    var body: some View {
        
        VStack {
            VStack(){
                HStack {
                    Text("Navigate Your")
                    Text("Debt")
                        .foregroundColor(.pink)
                    Text("Transaction Easily")
                }
                .font(.title3)
                .fontWeight(.medium)
                .padding(3)
                
                Spacer()
                Spacer()
                
                HStack {
                    Text("Tap once")
                        .foregroundColor(.pink)
                    Text("on the bubble you like to see the nominal")
                }
                .font(.custom("SF Pro Text", size: 15.49))
                Spacer()
                
                HStack {
                    Text("Tap twice")
                        .foregroundColor(.pink)
                    Text("to expand the  detail")
                }
                .font(.custom("SF Pro Text", size: 15.49))
                Spacer()
            }
            .frame(height: 100)
            .fontWeight(.light)
            
            Spacer()
            
            ZStack(alignment: .center) {
                Circle()
                    .stroke(.blue)
                
//                BubbleView(data: $data, spacing: 0, startAngle: 180, clockwise: true)
//                    .font(.caption)
                
            }
            
            Spacer()
            
            Text("^")
                .fontWeight(.black)
            Text("Slide to Add New Transaction")
                .fontWeight(.medium)
        }
        .padding()
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
