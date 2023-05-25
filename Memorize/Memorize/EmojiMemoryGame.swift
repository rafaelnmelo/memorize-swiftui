//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Rafael Melo on 19/05/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    //static faz a var/func ser global porem dentro de sua classe
    private static var emojis = ["🍆", "🍑", "🍌", "🍍", "🍏", "🍎", "🍊", "🍐", "🍉", "🍇", "🍓", "🫐", "🍒", "🍈", "🥭", "🥥", "🥝", "🍅", "🥑", "🌶"]
    
    private static func creatMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numbreOfPairsOfCards: 6) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    //apenas a ViewModel pode ter acesso
    @Published private var model = creatMemoryGame()
    
    //para acesso aos cards criar uma get only var
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
