//
//  Cardify.swift
//  Memorize
//
//  Created by Rafael Melo on 25/05/23.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            //Iniciar com borda arredondada
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                // Preencher fundo com cor branca
                shape.fill().foregroundColor(.white)
                // Retangulo com borda apenas
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                // Preencher background da cor padrão
                shape.fill()
            }
            //deixará sempre carregada porem opacidade de acordo com o param
            content.opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
