import SwiftUI

struct SecondView: View {
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
            Spacer()
            
            //  Lazy - позволяет в данном случае сэкономить ресурсы, так как будет отрисовывать только те элементы, которые в пределах экрана.
            //  Ставим spacing между рядами (сверху снизу)
            LazyVGrid(columns: columns, spacing: 8) {
                //  Расставляем каждую кнопку с помощью цикла
                ForEach(buttons, id: \.self) { button in
                    UIKitButton(text: button)
                        //  Делаем кнопки квадратной формы
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    SecondView()
}
