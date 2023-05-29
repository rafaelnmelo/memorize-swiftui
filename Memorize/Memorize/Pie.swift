//
//  Pie.swift
//  Memorize
//
//  Created by Rafael Melo on 24/05/23.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise = false
    
    var animatableData: AnimatablePair<Double,Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        var p = Path()
        let start = CGPoint(x: center.x + radius * CGFloat(cos(startAngle.radians)),
                            y: center.y + radius * CGFloat(sin(startAngle.radians)))
        
        p.move(to: center) //iniciar no centro do shape
        p.addLine(to: start) //criar uma linha para o ponto de inicio a partir do centro
        p.addArc(center: center,
                 radius: radius,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: !clockwise)
        p.addLine(to: center)
        
        return p
    }
}
