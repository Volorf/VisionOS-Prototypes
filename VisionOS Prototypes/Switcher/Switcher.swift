//
//  Switcher.swift
//  VisionOS Prototypes
//
//  Created by Oleg Frolov on 05/01/2024.
//

import SwiftUI
import RealityKit

struct Switcher: View {
    
    var body: some View
    {
        VStack
        {
            HStack(spacing: 0)
            {
                RealityView
                {
                    content in
                }
                
                .frame(width: 48)
                .background(Color.green)
                .padding(.leading, 48.0)
                
                VStack(alignment: .leading)
                {
                    Spacer()
                    Text("Vision OS")
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
        
    }
}

#Preview {
    Switcher()
}
