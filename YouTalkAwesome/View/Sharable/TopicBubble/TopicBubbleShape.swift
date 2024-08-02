//
//  TopicBubble.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/31/24.
//

import SwiftUI

struct TopicBubbleShape: Shape {
    
    let curveDistance = 20
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let intWidth = Int(rect.size.width)
        let intHeigth = Int(rect.size.height)
        
        path.move(to: CGPoint(x: curveDistance, y: 0))
        path.addLine(to: CGPoint(x: intWidth - curveDistance , y: 0))
        path.addQuadCurve(to: CGPoint(x: intWidth, y: curveDistance), control: CGPoint(x: intWidth, y: 0))
        path.addLine(to: CGPoint(x: intWidth, y: intHeigth - curveDistance))
        path.addQuadCurve(to: CGPoint(x: intWidth - curveDistance, y: intHeigth), control: CGPoint(x: intWidth, y: intHeigth))
        path.addLine(to: CGPoint(x: curveDistance, y: intHeigth))
        path.addLine(to: CGPoint(x: curveDistance / 2, y: intHeigth + (curveDistance / 2)))
        path.addQuadCurve(to: CGPoint(x: 0, y: intHeigth + (curveDistance / 2)), control: CGPoint(x: 0, y: intHeigth + curveDistance))
        path.addLine(to: CGPoint(x: 0, y: curveDistance))
        path.addQuadCurve(to: CGPoint(x: curveDistance, y: 0), control: CGPoint(x: 0, y: 0))
        
        return path
    }
}

#Preview {
    VStack {
        TopicBubbleShape()
            .stroke(.bk)
            .frame(width: 205, height: 110)
            .padding()
        TopicBubbleShape()
            .stroke(.bk)
            .frame(width: 353, height: 110)
    }
}
