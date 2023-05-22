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
    
    //mutating habilita a função modificar a struct
    mutating func choose(_ card: Card) {
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0
    }
    //como não sabemos o conteudo de cada card
    //passamos uma função que retorna o tipo flexivel "CardContent"
    init(numbreOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numbreOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent ///Uso de generic type para flexibilização do conteudo de cada card
        var id: Int
    }
}
