//  KeypadButton.swift
//  Created by Oleg Frolov on 11/01/2024.

import SwiftUI

struct KeypadButton: View
{
    let name: String
    let isActive: Bool
    let isDisabled: Bool
    
    @State private var isPressed: Bool = false
    @State private var fingerPrints: [Coords] = []
    @State private var isHovering: Bool = false
    
    let action: ((_ n: String) -> Void)
    
    var body: some View
    {
        VStack
        {
            ZStack
            {
                Text(name)
                    .frame(width: 64)
                
                    .font(.custom("IBMPlexMono-Medium", size: 12))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(isActive ? Color("Dark") : isDisabled ? .white.opacity(0.1) : .white)
                
                ForEach(fingerPrints, id: \.self) { fingerPrint in
                    FingerPrint(position: fingerPrint)
                }
            }
            .frame(width: 64, height: 64)
            .background(isActive ? Color("Accent") : isDisabled ? .white.opacity(0.025) : .white.opacity(0.1))
            .cornerRadius(8)
            .glassBackgroundEffect()
            .scaleEffect(isPressed ? 0.9 : 1)
            .animation(.spring(), value: isPressed)
            .animation(.easeInOut, value: isActive)
            .animation(.easeInOut, value: isDisabled)
        }
        .simultaneousGesture(DragGesture(minimumDistance: 0)
        .onChanged
        {
            touchData in
            if (!isPressed)
            {
                print("Down")
                isPressed = true
                print(touchData.location)
                fingerPrints.append(Coords(x: touchData.location.x, y: touchData.location.y))
            }
        }
        .onEnded
        {
            _ in
            if (isPressed)
            {
                print("Up")
                isPressed = false
                action(name)
            }
        })
    }
}

#Preview
{
    VStack()
    {
        KeypadButton(name: "0", isActive: true, isDisabled: false)
        {
            name in
            print(name)
        }
    }
}
