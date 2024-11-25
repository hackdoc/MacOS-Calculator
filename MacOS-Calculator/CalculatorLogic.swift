//
//  CalculatorLogic.swift
//  MacOS-Calculator
//
//  Created by Oliwer Pawelski on 20/11/2024.
//

extension ContentView {
    func buttonTapped(_ button: String) {
        if "0"..."9" ~= button || button == "." {
            if shouldResetDisplay {
                display = button == "." ? "0." : button
                shouldResetDisplay = false
            } else {
                display = display == "0" && button != "." ? button : display + button
            }
        } else if ["+", "-", "x", "/"].contains(button) {
            currentOperation = button
            firstOperand = Double(display)
            shouldResetDisplay = true
        } else if button == "=" {
            guard let firstOperand = firstOperand, let currentOperation = currentOperation, let secondOperand = Double(display) else { return }
            switch currentOperation {
            case "+": display = "\(firstOperand + secondOperand)"
            case "-": display = "\(firstOperand - secondOperand)"
            case "x": display = "\(firstOperand * secondOperand)"
            case "/": display = secondOperand != 0 ? "\(firstOperand / secondOperand)" : "Error"
            default: break
            }
            self.firstOperand = nil
            self.currentOperation = nil
            shouldResetDisplay = true
        } else if button == "C" {
            display = "0"
            firstOperand = nil
            currentOperation = nil
            shouldResetDisplay = false
        } else if button == "+/-" {
            if let value = Double(display) {
                display = "\(value * -1)"
            }
        } else if button == "%" {
            if let value = Double(display) {
                display = "\(value / 100)"
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
