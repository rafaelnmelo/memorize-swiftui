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
    
    mutating func shuffle() {
        cards.shuffle()
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
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent ///Uso de generic type para flexibilização do conteudo de cada card
        let id: Int
        
        // MARK: - Bonus Time
        
        //sendo zero, o card não tem bonus
        var bonusTimeLimit: TimeInterval = 6
        //o ultimo horario que o card esteve virado pra cima
        var lastFaceUpDate: Date?
        //tempo total de tempo virado pra cima
        var pastFaceUpTime: TimeInterval = 0
        //quanto tempo o card ficou virado pra cima
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        //quanto tempo falta pra acabar o bonus de tempo
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        //porcentagem de tempo disponivel
        var bonusRemaining: TimeInterval {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        //se o card foi combinado no tempo disponivel
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        //se esta virado, não combinado e sem ter usado bonus
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        // chamado ao transicionar para virado pra cima
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        //chamado quando o card é virado pra baixo ou combinado
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    
    }
}
