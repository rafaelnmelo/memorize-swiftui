//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Rafael Melo on 17/05/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(game.cards) { card in
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red) ///Cor de tudo dentro da scrollview
        .padding(.horizontal)///Espaçamento horizontal
        .font(.largeTitle)
    }
}

struct CardView: View {
    private var card: EmojiMemoryGame.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            //Iniciar com borda arredondada
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                // Preencher fundo com cor branca
                shape.fill().foregroundColor(.white)
                // Retangulo com borda apenas
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                // Preencher background da cor padrão
                shape.fill()
            }
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        // Configura preview com tema escuro
//        EmojiMemoryGameView(game: game).preferredColorScheme(.dark)
        // Apresenta outro review com tema claro
        EmojiMemoryGameView(game: game).preferredColorScheme(.light).previewInterfaceOrientation(.portrait)
    }
}
