//
//  FingerPrint.swift
//  ButtonThatRemembers
//
//  Created by Oleg Frolov on 18/12/2023.
//

import SwiftUI

struct Coords: Hashable
{
    var x: Double
    var y: Double
}

struct FingerPrint: View
{
    var position: Coords
    @State private var angleOffset: Double = 0
    @State private var opacityOffset: Double = 0
    @State private var imageName: String = "Finger Print 5"
    
    var body: some View
    {
        ZStack()
        {
            Image(imageName)
                .resizable()
                .rotationEffect(.degrees(angleOffset))
                .opacity(opacityOffset)
                .scaleEffect(0.75)
                .offset(y: 16)
        }
//        .blendMode(.overlay)
        .frame(width: 128, height: 128)
        .cornerRadius(8)
        .position(x: position.x, y: position.y)
        .onAppear()
        {
            angleOffset = Double.random(in: -20...20)
            opacityOffset = Double.random(in: 0.2...0.6)
            imageName = "Finger Print \(Int.random(in: 1..<5))"
//            imageName = "Finger Print"
        }
    }
}

#Preview {
    FingerPrint(position: Coords(x: 100, y: 100))
}
