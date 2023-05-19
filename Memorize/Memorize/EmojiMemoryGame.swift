//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rafael Melo on 19/05/23.
//

import SwiftUI

class EmojiMemoryGame {
    
    //static faz a var/func ser global porem dentro de sua classe
    static var emojis = ["🍆", "🍑", "🍌", "🍍", "🍏", "🍎", "🍊", "🍐", "🍉", "🍇", "🍓", "🫐", "🍒", "🍈", "🥭", "🥥", "🥝", "🍅", "🥑", "🌶"]
    
    static func creatMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numbreOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    //apenas a ViewModel pode ter acesso
    private var model = creatMemoryGame()
    
    //para acesso aos cards criar uma get only var
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
