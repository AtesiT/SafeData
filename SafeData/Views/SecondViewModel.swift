import SwiftUI
import Combine

class SecondViewModel: ObservableObject {
    @Published var showThirdView = false
    @Published var message = ""
    //  Flexible - позволяет занять колонкам столько места, сколько нужно будет. Но с учётом того, что колонок всего 4 будет.
    let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)
    
    let buttons = [
            "-", "+", "*", "/",
            "7", "8", "9", "=",
            "4", "5", "6", "C",
            "1", "2", "3", "0",
    ]
    
    init() {}
    
    func tapOnButton(_ theButton: String) {
        print("The button \"\(theButton)\" was pressed")
        
        switch theButton {
        case "0": message += "0"
        case "1": message += "1"
        case "2": message += "2"
        case "3": message += "3"
        case "4": message += "4"
        case "5": message += "5"
        case "6": message += "6"
        case "7": message += "7"
        case "8": message += "8"
        case "9": message += "9"
            
        case "+": message += "+"
        case "-": message += "-"
        case "*": message += "*"
        case "/": message += "/"
        
        case "C": message = ""
        
        default:
            message = String(resultOfNumbers(message))
            break
        }
    }
    
    func resultOfNumbers(_ theString: String) -> Int {
        //  It will be work if we will make action with two numbers and one action
        var action = ""
        var firstNumber = ""
        var secondNumber = ""
        var result = 0
        
        var atFirst = true
        
        for symbol in theString {
            let strSymbol = String(symbol)
            
            switch strSymbol {
            case "+", "-", "*", "/":
                action = strSymbol
                atFirst = false
            default:
                if atFirst {
                    firstNumber += strSymbol
                } else {
                    secondNumber += strSymbol
                }
            }
        }
        
        switch action {
        case "+":
            result = (Int(firstNumber) ?? 0) + (Int(secondNumber) ?? 0)
        case "-":
            result = (Int(firstNumber) ?? 0) - (Int(secondNumber) ?? 0)
        case "*":
            result = (Int(firstNumber) ?? 0) * (Int(secondNumber) ?? 0)
        case "/":
            result = (Int(firstNumber) ?? 0) / (Int(secondNumber) ?? 0)
        default:
            print("Test")
        }
        
        //  Secret code to move on ThirdView
        if result == 1234 {
            showThirdView = true
        }
        
        return result
    }
    
}
