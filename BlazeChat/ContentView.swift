//
//  ContentView.swift
//  BlazeChat
//
//  Created by De MicheliStefano on 10.01.21.
//

import LightningKit
import SwiftUI

struct ContentView: View {
    
    init() {
        LKChannel.shared.start()
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
