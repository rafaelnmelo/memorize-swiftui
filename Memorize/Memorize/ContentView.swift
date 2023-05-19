//
//  ContentView.swift
//  Memorize
//
//  Created by Rafael Melo on 17/05/23.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🍆", "🍑", "🍌", "🍍", "🍏", "🍎", "🍊", "🍐", "🍉", "🍇", "🍓", "🫐", "🍒", "🍈", "🥭", "🥥", "🥝", "🍅", "🥑", "🌶"]
    
    @State var emojiCount = 20
    
    var body: some View {
        VStack {///Organizando as vews verticalmente
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red) ///Cor de tudo dentro da scrollview
            .padding(.horizontal)///Espaçamento horizontal
            .font(.largeTitle)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var content: String
    // Torna a var um pointer
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            //Iniciar com borda arredondada
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                // Preencher fundo com cor branca
                shape.fill().foregroundColor(.white)
                // Retangulo com borda apenas
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                // Preencher background da cor padrão
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Configura preview com tema escuro
//        ContentView().preferredColorScheme(.dark)
        // Apresenta outro review com tema claro
        ContentView().preferredColorScheme(.light).previewInterfaceOrientation(.portrait)
    }
}
