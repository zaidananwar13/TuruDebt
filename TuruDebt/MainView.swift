//
//  ContentView.swift
//  TuruDebt
//
//  Created by Zaidan Anwar on 31/03/23.
//

import SwiftUI

struct BubbleView: View {
    @Binding var data: [DataItem]
    
    @State private var mySize = ViewSize()
    @State private var offset:CGSize = .zero
    
    // Spacing between bubbles
    var spacing: CGFloat
    
    // startAngle in degrees -360 to 360 from left horizontal
    var startAngle: Int
    
    // direction
    var clockwise: Bool
    
    var body: some View {
         
        let xSize = (mySize.xMax - mySize.xMin) == 0 ? 1 : (mySize.xMax - mySize.xMin)
        let ySize = (mySize.yMax - mySize.yMin) == 0 ? 1 : (mySize.yMax - mySize.yMin)

        GeometryReader { geo in
            let xScale = geo.size.width / xSize
            let yScale = geo.size.height / ySize
            let scale = min(xScale, yScale)

            ZStack {
                ForEach(data, id: \.id) { item in
                    ZStack {
                        Bulet(viewSize: $mySize, item: item, scale: scale)
                        
                    }
                    

                }
            }
            .offset(x: xOffset() * scale, y: yOffset() * scale)
        }
        .onAppear {
            setOffets()
            mySize = absoluteSize()
        }
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
    
    // Calculate alpha from sides - 1. Cosine theorem
    func calculateAlpha(_ a: CGFloat, _ b: CGFloat, _ c: CGFloat) -> CGFloat {
        return acos(
            ( pow(a, 2) - pow(b, 2) - pow(c, 2) )
            /
            ( -2 * b * c ) )
        
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
}


struct MainView: View {
    @State private var data: [DataItem] = [
            DataItem(title: "Ahmad", size: 180, color: .blue),
            DataItem(title: "Bagas", size: 60, color: .blue),
            DataItem(title: "Cika", size: 90, color: .blue),
            DataItem(title: "Edd", size: 30, color: .blue),
            DataItem(title: "Florence", size: 50, color: .blue),
            DataItem(title: "Gugus", size: 120, color: .blue),
            DataItem(title: "Hijrul", size: 60, color: .blue),
            DataItem(title: "Ica", size: 90, color: .blue),
            DataItem(title: "Joko", size: 30, color: .blue),
            DataItem(title: "Kevin", size: 25, color: .blue)
        ]
    
    var body: some View {
        VStack {
            
            Text("Navigate Your Debt Transaction Easily")
                .padding(3)
                .fontWeight(.medium)
            Text("Tap once on the bubble you like to see the nominal, or twice to expand the  detail")
                .fontWeight(.light)
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 100)
            
            ZStack {
                BubbleView(data: $data, spacing: 10, startAngle: 180, clockwise: true)
                    .font(.caption)
            }
            
            Text("^")
                .fontWeight(.black)
            Text("Slide to Add New Transaction")
                .fontWeight(.medium)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
