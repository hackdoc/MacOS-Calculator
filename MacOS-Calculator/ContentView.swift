//
//  ContentView.swift
//  MacOS-Calculator
//
//  Created by Oliwer Pawelski on 20/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State var display = "0"
    @State var firstOperand: Double?
    @State var currentOperation: String?
    @State var shouldResetDisplay = false

    let buttons: [[String]] = [
        ["C", "+/-", "%", "/"],
        ["7", "8", "9", "x"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]

    var body: some View {
        ZStack {
            // Frosted Glass Effect
            Color.clear
                .background(VisualEffectBlur())
            
            VStack(spacing: 10) {
                // Display
                Text(display)
                    .font(.system(size: 40))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Buttons Grid
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {buttonTapped(button)} ) {
                                Text(button)
                                    .font(.system(size: 28))
                                    .frame(width: button == "0" ? 166 : 70, height: 70)
                                    .background(.clear)
                                    .foregroundColor(.white)
                            }.background(buttonColor(for: button))
                                .cornerRadius(100)
                        }
                        //.clipShape(Circle())
                    }
                }
            }
        }
        .frame(width: 400, height: 510)
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)) { _ in
            NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
                handleKeyPress(event: event)
                return event
            }
        }
    }
    
    // Kolory przycisków
    func buttonColor(for button: String) -> Color {
        if ["+", "-", "x", "/", "="].contains(button) {
            return Color.orange
        } else if ["C", "+/-", "%"].contains(button) {
            return Color.gray
        } else {
            return Color(red:0.33, green: 0.33, blue: 0.33)
        }
    }
    
    // Obsługa klawiatury
    func handleKeyPress(event: NSEvent) {
        guard let characters = event.characters else { return }

        switch characters {
        case "0"..."9", ".", "+", "-", "/", "*", "x", "=":
            buttonTapped(characters == "*" ? "x" : characters) // Zamień "*" na "x"
        case "c", "C":
            buttonTapped("C")
        case "\r": // Enter
            buttonTapped("=")
        default:
            break
        }
    }
}

#Preview {
    ContentView()
}
