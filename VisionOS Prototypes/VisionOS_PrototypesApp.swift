//
//  VisionOS_PrototypesApp.swift
//  VisionOS Prototypes
//
//  Created by Oleg Frolov on 05/01/2024.
//

import SwiftUI

@main
struct VisionOS_PrototypesApp: App 
{
    var body: some Scene 
    {
        WindowGroup 
        {
            Switcher1()
//            Switcher2()
//            Switcher3()
//            Keypad()
        }
        .windowStyle(.volumetric)
    }
}
