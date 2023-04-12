//
//  TestSwitchPage.swift
//  TuruDebt
//
//  Created by Zaidan Anwar on 11/04/23.
//

import SwiftUI

struct TestSwitchPage: View {
    @Binding var onClose: Bool
    
    var name: String
    
    var body: some View {
        VStack {
            Text("Howdy, \(name)")
        }
        .onDisappear {
            onClose = false
        }
    }
}
