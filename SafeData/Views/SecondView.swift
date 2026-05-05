import SwiftUI

struct SecondView: View {
    @State private var message = ""
    //  Flexible - позволяет занять колонкам столько места, сколько нужно будет. Но с учётом того, что колонок всего 4 будет.
    let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)
    
    let buttons = [
            "-", "+", "*", "/",
            "7", "8", "9", "=",
            "4", "5", "6", "C",
            "1", "2", "3", "0",
    ]
    
    var body: some View {
        VStack {
            UIKitLabel(text: message, color: .black, size: 40)
            
            //  Для оставления пространства между кнопками и label
            Spacer()
            
            //  Lazy - позволяет в данном случае сэкономить ресурсы, так как будет отрисовывать только те элементы, которые в пределах экрана.
            //  Ставим spacing между рядами (сверху снизу)
            LazyVGrid(columns: columns, spacing: 8) {
                //  Расставляем каждую кнопку с помощью цикла
                ForEach(buttons, id: \.self) { button in
                    UIKitButton(text: button, size: 40) {
                        tapOnButton(button)
                    }
                        //  Делаем кнопки квадратной формы
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            .padding()
        }
    }
    
    private func tapOnButton(_ theButton: String) {
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
            //  It will be a equality =
            break
        }
    }
}

#Preview {
    SecondView()
}
