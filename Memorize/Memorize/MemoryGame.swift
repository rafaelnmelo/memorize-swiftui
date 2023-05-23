//
//  MemoryGame.swift
//  Memorize
//
//  Created by Rafael Melo on 19/05/23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    //proteger para alteração fora da struct
    private(set) var cards: [Card]
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        //filtra o array e retorna o univo card virado para cima
        get { cards.indices.filter{ cards[$0].isFaceUp }.oneAndOnly }
        //percorre o array para setar o novo valor
        set { cards.indices.forEach{ cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    //mutating habilita a função modificar a struct
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }

    //como não sabemos o conteudo de cada card
    //passamos uma função que retorna o tipo flexivel "CardContent"
    init(numbreOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numbreOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent ///Uso de generic type para flexibilização do conteudo de cada card
        let id: Int
    }
}
