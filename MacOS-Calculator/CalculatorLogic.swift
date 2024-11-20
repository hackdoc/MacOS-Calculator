//
//  CalculatorLogic.swift
//  MacOS-Calculator
//
//  Created by Oliwer Pawelski on 20/11/2024.
//

extension ContentView {
    func buttonTapped(_ button: String) {
        if let number = Int(button) {
            if shouldResetDisplay {
                display = "\(number)"
                shouldResetDisplay = false
            } else {
                display = display == "0" ? "\(number)" : display + "\(number)"
            }
        } else {
            switch button {
            case "C":
                display = "0"
                firstOperand = nil
                currentOperation = nil
                shouldResetDisplay = false
            case "+", "-", "x", "/":
                firstOperand = Double(display)
                currentOperation = button
                shouldResetDisplay = true
            case "=":
                if let firstOperand = firstOperand, let currentOperation = currentOperation {
                    let secondOperand = Double(display) ?? 0
                    let result: Double

                    switch currentOperation {
                    case "+":
                        result = firstOperand + secondOperand
                    case "-":
                        result = firstOperand - secondOperand
                    case "x":
                        result = firstOperand * secondOperand
                    case "/":
                        result = secondOperand == 0 ? 0 : firstOperand / secondOperand
                    default:
                        return
                    }

                    display = "\(result)"
                    self.firstOperand = nil
                    self.currentOperation = nil
                }
            case ".":
                if !display.contains(".") {
                    display += "."
                }
            default:
                break
            }
        }
    }

    func numberTapped(_ number: String) {
        if shouldResetDisplay {
            display = number
            shouldResetDisplay = false
        } else {
            display = display == "0" ? number : display + number
        }
    }

    func operationTapped(_ operation: String) {
        switch operation {
        case "C":
            clear()
        case "+/-":
            toggleSign()
        case "%":
            percentage()
        case "+", "-", "x", "/":
            setOperation(operation)
        case "=":
            calculateResult()
        default:
            break
        }
    }

    func clear() {
        display = "0"
        firstOperand = nil
        currentOperation = nil
        shouldResetDisplay = false
    }

    func toggleSign() {
        if let value = Double(display) {
            display = String(-value)
        }
    }

    func percentage() {
        if let value = Double(display) {
            display = String(value / 100)
        }
    }

    func setOperation(_ operation: String) {
        firstOperand = Double(display)
        currentOperation = operation
        shouldResetDisplay = true
    }

    func calculateResult() {
        if let firstOperand = firstOperand,
           let secondOperand = Double(display),
           let operation = currentOperation {
            switch operation {
            case "+":
                display = String(firstOperand + secondOperand)
            case "-":
                display = String(firstOperand - secondOperand)
            case "x":
                display = String(firstOperand * secondOperand)
            case "/":
                display = secondOperand != 0 ? String(firstOperand / secondOperand) : "Error"
            default:
                break
            }
            self.firstOperand = nil
            self.currentOperation = nil
            self.shouldResetDisplay = true
        }
    }
}
