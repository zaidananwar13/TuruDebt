//
//  SwiftUIViewControl.swift
//  TuruDebt
//
//  Created by Zaidan Anwar on 06/04/23.
//

import SwiftUI

struct SwiftUIViewControl: View {
//    State object & ObservedObject
    @State private var isToggled = false
    @State private var lampName = ""
    
    var body: some View {
        VStack {
            VStack {
                TextField("Your lamp name", text: $lampName)
                    .frame(width: 200)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                
                Toggle(isOn: $isToggled) {
                    Text("💡")
                }
                .frame(width: 100)
                
                Text("\(lampName != "" ? lampName : "Lamp") is \(isToggled ? "oN" : "oFF")")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(isToggled ? .gray : .gray)
            .opacity(isToggled ? 1 : 0.1)
        }
        .animation(.easeInOut, value: 3)
    }
}

struct SwiftUIViewControl_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewControl()
    }
}
