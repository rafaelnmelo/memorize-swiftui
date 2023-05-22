//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Rafael Melo on 17/05/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
