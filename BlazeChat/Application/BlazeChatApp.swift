//
//  BlazeChatApp.swift
//  BlazeChat
//
//  Created by De MicheliStefano on 10.01.21.
//

import LightningKit
import SwiftUI

@main
struct BlazeChatApp: App {
    
    init() {
        setupLnd()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

private extension BlazeChatApp {
    
    func setupLnd() {
        LKChannel.shared.start()
    }
}
