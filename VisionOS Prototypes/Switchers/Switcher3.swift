//
//  Switcher.swift
//  VisionOS Prototypes
//
//  Created by Oleg Frolov on 05/01/2024.
//

import SwiftUI
import RealityKit

struct Switcher3: View
{
//    private let dotScale: SIMD3<Float> = [1.0, 1.0, 1.0]
//    private let dotTranslation: SIMD3<Float> = [0.0, 0.0, -0.2]
    private let dotScale: SIMD3<Float> = [0.5, 0.5, 0.5]
    private let dotTranslation: SIMD3<Float> = [0.0, 0.0, -0.4695]

    private let dotYOffset: Double = 72.0
    private let angleOffset: Double = 10.0
    private let animDuration: Double = 1.0
    private let flatDotYOffset: Double = 40.0
    
    private let highOpacity: Double = 1.0
    private let lowOpacity: Double = 0.2
    
    @State private var isPressed: Bool = false;
    @State private var isFirstSelected: Bool = true;
    @State private var currentYDotOffset: Double = 0.0
    @State private var currentFlatDotYOffset: Double = 0.0
    @State private var currentAndleOffset: Double = 0.0
    
    private var mat1: SimpleMaterial = SimpleMaterial(color: .white, roughness: 0.0, isMetallic: true)
    private var mat2: SimpleMaterial = SimpleMaterial(color: .gray, roughness: 1.0, isMetallic: false)
    
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
                        .frame(width: 32, height: 32)
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
                        
                        async let dot = ModelEntity(named: "CylindricButton")
                        
                        if let dot = try? await dot
                        {
                            dot.transform.scale = dotScale
                            dot.transform.translation = dotTranslation
//                            if var material = dot.model?.materials.first as? SimpleMaterial
//                            {
//                                material.roughness = isFirstSelected ? 0.1 : 1.0
//                                dot.model?.materials = [material]
//                            }
                            content.add(dot)
                        }
                    }
                    update : { content in
                        print("heyyyyyy")
                        let c = content.entities[0] as! ModelEntity
                        
//                        withAnimation
//                        {
//                            c.model?.materials = [isFirstSelected ? mat1 : mat2]
//                        }
                        
                        
                        
                        content.add(c)
                        
                    }
//                    .opacity(isFirstSelected ? highOpacity : lowOpacity)
                    .padding3D(.bottom, currentYDotOffset)
                    .animation(.bouncy(duration: animDuration), value: currentYDotOffset)
                    
                
                }
                .frame(width: 48)
                .padding(.leading, 48.0)

                VStack(alignment: .leading, spacing: 0)
                {
                    Spacer()
                    
                    Text("On").opacity(!isFirstSelected ? lowOpacity : highOpacity)
                    
                    Spacer()
                        .frame(height: 42)
                    
                    Text("Off").opacity(isFirstSelected ? lowOpacity : highOpacity)
                    
                    Spacer()
                }
                .font(.system(size: 32))
                .fontWeight(.regular)
                .padding(.leading, 24.0)

                Spacer()
            }
            
        }
        
        .frame(width: 224, height: 224)
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
    Switcher3()
}


