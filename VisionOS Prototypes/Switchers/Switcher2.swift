//
//  Switcher.swift
//  VisionOS Prototypes
//
//  Created by Oleg Frolov on 05/01/2024.
//

import SwiftUI
import RealityKit

struct Switcher2: View
{
//    private let dotScale: SIMD3<Float> = [1.0, 1.0, 1.0]
    private let dotScale: SIMD3<Float> = [0.75, 0.75, 0.75]
    private let dotTranslation: SIMD3<Float> = [0.0, 0.0, -0.4525]
//    private let dotTranslation: SIMD3<Float> = [0.0, 0.0, -0.175]
    private let dotYOffset: Double = 72.0
    private let angleOffset: Double = 10.0
    private let animDuration: Double = 1.0
    private let flatDotYOffset: Double = 40.0
    
    private let highOpacity: Double = 0.8
    private let lowOpacity: Double = 0.2
    
    @State private var isPressed: Bool = false;
    @State private var isFirstSelected: Bool = true;
    @State private var currentYDotOffset: Double = 0.0
    @State private var currentFlatDotYOffset: Double = 0.0
    @State private var currentAndleOffset: Double = 0.0
    
    var body: some View
    {
        VStack
        {
            HStack(spacing: 0)
            {
                ZStack
                {
                    Capsule()
                        .frame(width: 48, height: 128)
                        .opacity(0.1)
                    
                    Circle()
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                        .offset(y: -currentFlatDotYOffset)
                        .animation(.bouncy(duration: animDuration), value: currentFlatDotYOffset)
                        .opacity(0.5)
                        .blur(radius: 16)
                        .blendMode(.multiply)
                    
                    
//                    Circle()
//                        .frame(width: 48, height: 48)
//                        .offset(y: currentFlatDotYOffset)
//                        .animation(.bouncy(duration: animDuration), value: currentFlatDotYOffset)
//                        .opacity(0.2)
                    
                    RealityView
                    {
                        content in
                        
                        async let dot = ModelEntity(named: "sphere_1m")
                        
                        if let dot = try? await dot
                        {
                            dot.transform.scale = dotScale
                            dot.transform.translation = dotTranslation
                            content.add(dot)
                        }
                    }
                    .padding3D(.bottom, currentYDotOffset)
                    .animation(.bouncy(duration: animDuration), value: currentYDotOffset)
                
                }
                .frame(width: 48)
                .padding(.leading, 48.0)

                VStack(alignment: .leading, spacing: 0)
                {
                    Spacer()
                    
                    Text("Fork").opacity(!isFirstSelected ? lowOpacity : highOpacity)
                    
                    Spacer()
                        .frame(height: 42)
                    
                    Text("Spoon").opacity(isFirstSelected ? lowOpacity : highOpacity)
                    
                    Spacer()
                }
                .font(.system(size: 32))
                .fontWeight(.regular)
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                .kerning(4.0)
                .padding(.leading, 24.0)

                Spacer()
            }
            
        }
        
        .frame(width: 320, height: 224)
        .glassBackgroundEffect()
        .background(isPressed ? .white.opacity(0.5) : .clear)
        .cornerRadius(48)
        .gesture(DragGesture(minimumDistance: 0)
            .onChanged { _ in
                
                if (!isPressed)
                {
                    isPressed = true
                    isFirstSelected.toggle()
                    
                    currentYDotOffset = isFirstSelected ? dotYOffset : -dotYOffset
                    
                    currentFlatDotYOffset = isFirstSelected ? flatDotYOffset : -flatDotYOffset
                    
                    currentAndleOffset = isFirstSelected ? angleOffset : -angleOffset
                    print("Down")
                }
            }
            .onEnded { _ in
                if (isPressed)
                {
                    currentAndleOffset = 0.0
                    isPressed = false
                    print("Up")
                }
            })
        
        .onAppear()
        {
            currentYDotOffset = dotYOffset
            currentFlatDotYOffset = flatDotYOffset
        }
        .offset(z: 24)
        .rotation3DEffect(.degrees(currentAndleOffset), axis: (1.0, 0.0, 0.0), anchor: UnitPoint3D(x: 0.0, y: 0.5, z: 0.0))
        .animation(.bouncy(duration: animDuration), value: currentAndleOffset)
    }
}

#Preview {
    Switcher2()
}
