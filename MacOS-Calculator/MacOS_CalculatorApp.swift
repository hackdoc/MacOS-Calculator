//
//  MacOS_CalculatorApp.swift
//  MacOS-Calculator
//
//  Created by Oliwer Pawelski on 20/11/2024.
//

import SwiftUI

@main
struct MacOS_CalculatorApp: App {
    init() {
        // Set permanent dark mode
        NSApplication.shared.appearance = NSAppearance(named: .vibrantDark)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(HiddenTitleBarWindowStyle()) // Integrated titlebar
        .commands {
            CommandGroup(replacing: .windowSize) {} // Disable window resizing
        }
    }
}
