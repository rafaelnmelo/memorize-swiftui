//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Rafael Melo on 17/05/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
