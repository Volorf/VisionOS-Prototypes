//
//  Switcher.swift
//  VisionOS Prototypes
//
//  Created by Oleg Frolov on 05/01/2024.
//

import SwiftUI
import RealityKit

struct Switcher: View {
    
    private let dotScale: SIMD3<Float> = [1, 1, 1]
    private let dotTranslation: SIMD3<Float> = [0.0, 0.0, -0.446]
    private let dotYOffset: Double = 80
    
    private let flatDotYOffset: Double = 40
    
    @State private var isPressed: Bool = false;
    @State private var isFirstSelected: Bool = true;
    @State private var currentYDotOffset: Double = 0.0
    @State private var currentFlatDotYOffset: Double = 0.0
    
    var body: some View
    {
        VStack
        {
            HStack(spacing: 0)
            {
                ZStack
                {
                    
//                    Capsule()
//                        .frame(width: 48, height: 128)
//                        .opacity(0.1)
                    
                    Circle()
                        .frame(width: 48, height: 48)
                        .offset(y: currentFlatDotYOffset)
                        .animation(.bouncy(duration: 0.5), value: currentFlatDotYOffset)
                        .opacity(0.2)
                    
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
                    .animation(.bouncy(duration: 0.5), value: currentYDotOffset)    
                
                }
                
                
                
                
                .frame(width: 48)
//                .background(Color.green)
                .padding(.leading, 48.0)

                VStack(alignment: .leading, spacing: 0)
                {
                    Spacer()
                    Text("Vision Pro")
                    Spacer()
                        .frame(height: 42)
                    Text("Meta Quest")
                    Spacer()
                }
                .font(.custom("SF Pro Display", size: 32))
//                .background(Color.black)
                .padding(.leading, 24.0)

                Spacer()
            }
            
        }
        
        .frame(width: 480, height: 224)
//        .background(Color.red)
        .glassBackgroundEffect()
        .cornerRadius(48)
        
        .gesture(DragGesture(minimumDistance: 0)
            .onChanged { _ in
                
                if (!isPressed)
                {
                    isPressed = true
                    isFirstSelected.toggle()
                    
                    currentYDotOffset = isFirstSelected ? dotYOffset : -dotYOffset
                    
                    currentFlatDotYOffset = isFirstSelected ? flatDotYOffset : -flatDotYOffset
                    print("\(currentYDotOffset)")
                    print("Down")
                    
                }
            }
            .onEnded { _ in
                if (isPressed)
                {
                    isPressed = false
                    print("Up")
                }
            })
        
        .onAppear()
        {
            currentYDotOffset = dotYOffset
            currentFlatDotYOffset = flatDotYOffset
        }
    }
}

#Preview {
    Switcher()
}
