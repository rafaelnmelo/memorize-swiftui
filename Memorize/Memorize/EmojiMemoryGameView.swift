//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Rafael Melo on 17/05/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        VStack {
            gameBody
            deckBody
            shuffle
        }
        //Espaçamento das margens
        .padding()
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool{
        !dealt.contains(card.id)
    }
    //calcular delay da animação  para sair cada card por vez do deck
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: CardConstants.aspectRatio) { card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp {
                //Esconder a view
                Color.clear
            } else {
                CardView(card)
                    //fazer animação conjunta com o deck
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    //transição ao sumir e aparecer
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    //Ajustar posição dos card no deck
                    .zIndex(zIndex(of: card))
                    //ação de toque
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
        //Cor de tudo dentro da view
        .foregroundColor(CardConstants.redColor)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card)
                    //fazer animação conjunta com o deck
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.redColor)
        .onTapGesture {
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }
    
    private struct CardConstants {
        static let redColor: Color = .red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
}

struct CardView: View {
    private var card: EmojiMemoryGame.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90),
                    endAngle: Angle(degrees: 110-90))
                .padding(DrawingConstants.circlePadding)
                .opacity(DrawingConstants.circleOpacity)
                Text(card.content)
                    // se mudar para isMatched irá fazer a rotação senão, manterá a posição
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    //duração e formato da transição
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    //necessário pois a string não é animável
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let circlePadding: CGFloat = 5
        static let circleOpacity: CGFloat = 0.5
        static let fontSize: CGFloat = 32
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        //iniciar com o primeiro card selecionado
//        game.choose(game.cards.first!)
        // Configura preview com tema escuro
        return EmojiMemoryGameView(game: game).preferredColorScheme(.dark)
        // Apresenta outro review com tema claro
//        return EmojiMemoryGameView(game: game).preferredColorScheme(.light).previewInterfaceOrientation(.portrait)
    }
}
