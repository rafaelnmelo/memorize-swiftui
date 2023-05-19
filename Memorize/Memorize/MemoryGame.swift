//
//  MemoryGame.swift
//  Memorize
//
//  Created by Rafael Melo on 19/05/23.
//

import Foundation

struct MemoryGame<CardContent> {
    //proteger para alteração fora da struct
    private(set) var cards: [Card]
    
    func choose(_ card: Card) {
        //TODO
    }
    //como não sabemos o conteudo de cada card
    //passamos uma função que retorna o tipo flexivel "CardContent"
    init(numbreOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numbreOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent ///Uso de generic type para flexibilização do conteudo de cada card
    }
}
