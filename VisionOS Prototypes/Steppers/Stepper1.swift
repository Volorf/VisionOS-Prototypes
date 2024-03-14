//
//  SwiftUIView.swift
//  VisionOS Prototypes
//
//  Created by Oleg Frolov on 14/03/2024.
//

import SwiftUI
import RealityKit

struct Stepper1: View
{
    enum Side
    {
        case Left
        case Right
        case Middle
    }
    
    // Settings
    private let angleOffset: Double = 20.0
    private let highOpacity: Double = 1.0
    private let lowOpacity: Double = 0.2
    private let buttonWidth: Double = 288.0
    private let buttonHeight: Double = 96.0
    private let sideTriggerArea: Double = 96.0
    private let anchorXOffset: Double = 48.0
    
    // Animation
    private let animDuration: Double = 0.5

    // State
    @State private var isPressed: Bool = false;
    @State private var currentAndleOffset: Double = 0.0
    @State private var pressedSide: Side = .Middle
    @State private var buttonAnchor: UnitPoint3D = UnitPoint3D(x: 0.5, y: 0.5, z: 0.0)
    @State private var decimalCounter: Int = 0
    @State private var easing: Animation = .easeOut
    @State private var counterScale: Double = 1.0
    
    
    var body: some View
    {
        VStack
        {
            HStack(spacing: 0)
            {

                HStack(spacing: 0)
                {
                    Image("minus").opacity(decimalCounter <= 0 ? 0.2 : 1.0).foregroundStyle(.secondary)
                    Spacer()
                    Text("\(String(decimalCounter, radix: 2))")
                        .animation(.none)
                        .frame(width: 128)
                        .foregroundStyle(.secondary)
                        .scaleEffect(counterScale)
                        
                        
                    Spacer()
                    Image("plus").foregroundStyle(.secondary)
                }
                .font(.system(size: 32, design: .monospaced))
                .fontWeight(.regular)
                .padding(36.0)
                
            }
            
            
        }
        .background(isPressed ? .white.opacity(0.1) : .clear)
        .glassBackgroundEffect()
        
        .frame(width: buttonWidth, height: buttonHeight)
        
        
        
        
        
        .rotation3DEffect(.degrees(currentAndleOffset), axis: (0.0, 1.0, 0.0), anchor: buttonAnchor)
        
        .offset(z: anchorXOffset * 2)
        .gesture(DragGesture(minimumDistance: 0)
            .onChanged { clickData in
                
                if (!isPressed)
                {
                    
                    
                    pressedSide = getSideThatWasPressed(clickData: clickData)
                    
                    let normXOffset = anchorXOffset / buttonWidth
                    
                    if (pressedSide == .Left)
                    {
                        currentAndleOffset = -angleOffset
                        buttonAnchor = UnitPoint3D(x: 1.0 - normXOffset, y: 0.5, z: normXOffset)
                    }
                    
                    if (pressedSide == .Right)
                    {
                        currentAndleOffset = angleOffset
                        buttonAnchor = UnitPoint3D(x: normXOffset, y: 0.5, z: normXOffset)
                    }
                    
                    easing = Animation.snappy(duration: animDuration/2)
                    
                    counterScale = 1.2
                    
//                    print(pressedSide)
                    print("Down")
//                    print(clickData)
                    
                    isPressed = true
                    
                }
            }
            .onEnded { _ in
                if (isPressed)
                {
                    isPressed = false
                    
                    currentAndleOffset = 0.0
                    
                    if (pressedSide == .Left)
                    {
                        if ((decimalCounter - 1) < 0)
                        {
                            decimalCounter = 0
                        }
                        else
                        {
                            decimalCounter -= 1
                        }
                    }
                    
                    if (pressedSide == .Right)
                    {
                        decimalCounter += 1
                    }
                    
                    easing = Animation.spring(duration: animDuration * 2)
                    
                    counterScale = 1.0
                    
                    print("Up")
                    
                }
            })
        
        .onAppear()
        {
            
        }
        
        .animation(easing, value: currentAndleOffset)
        .animation(easing, value: counterScale)
        
        
        
        
        
    }
    
    func getSideThatWasPressed(clickData: DragGesture.Value) -> Side
    {
        let xPos: Double = clickData.location.x;
        
        if (xPos <= sideTriggerArea)
        {
            return .Left
        }
        else if (xPos >= (buttonWidth - sideTriggerArea))
        {
            return .Right
        }
        else
        {
            return .Middle
        }
    }
}

#Preview {
    Stepper1()
}



