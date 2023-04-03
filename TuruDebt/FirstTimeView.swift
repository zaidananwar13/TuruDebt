//
//  FirstTimeView.swift
//  TuruDebt
//
//  Created by Zaidan Anwar on 03/04/23.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct FirstTimeView: View {
    @State private var fadeAwayState = false
    @State private var onTapState = false
    @State private var firstRing = 1.0
    @State private var secondRing = 1.0
    @State private var thirdRing = 1.0
    @State private var fourthRing = 1.0
    @State private var fifthRing = 1.0
    
    let gradientColors = [
        Color(hex: 0xEE7991),
        Color(hex: 0xEE7991),
        Color(hex: 0xEE7991),
        Color(hex: 0x9CC9FA),
        Color(hex: 0x9CC9FA)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Tap")
                    .foregroundColor(.pink)
                
                Text("to add New Transaction!")
            }
            
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: gradientColors),
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                    )
                    .scaleEffect(onTapState ? firstRing : 1)
                    .animation(.easeInOut, value: 3)
                
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: gradientColors),
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                    )
                    .scaleEffect(onTapState ? secondRing : 1)
                
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: gradientColors),
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                    )
                    .opacity(onTapState ? 1 : 0.0)
                    .scaleEffect(onTapState ? thirdRing : 0.5)
            
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: gradientColors),
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                    )
                    .opacity(onTapState ? 1 : 0.0)
                    .scaleEffect(onTapState ? fourthRing : 0.25)
                
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: gradientColors),
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                    )
                    .opacity(onTapState ? 1 : 0.0)
                    .scaleEffect(onTapState ? fifthRing : 0.125)
            }
            .padding(10)
            .opacity(fadeAwayState ? 0.1 : 1)
            .animation(.easeInOut, value: 5)
                
        }
        .onTapGesture {
            onTapState.toggle()
            
            withAnimation(.easeOut(duration: 2)) {
                firstRing = 6
                secondRing = 5
                thirdRing = 4
                fourthRing = 3
                fifthRing = 2.3
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    fadeAwayState = true
                }

            }
        }
    }
}

struct FirstTimeView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTimeView()
    }
}