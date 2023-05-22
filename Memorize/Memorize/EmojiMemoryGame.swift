//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rafael Melo on 19/05/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    //static faz a var/func ser global porem dentro de sua classe
    static var emojis = ["🍆", "🍑", "🍌", "🍍", "🍏", "🍎", "🍊", "🍐", "🍉", "🍇", "🍓", "🫐", "🍒", "🍈", "🥭", "🥥", "🥝", "🍅", "🥑", "🌶"]
    
    static func creatMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numbreOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    //apenas a ViewModel pode ter acesso
    @Published private var model = creatMemoryGame()
    
    //para acesso aos cards criar uma get only var
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
