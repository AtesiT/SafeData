import SwiftUI

struct SecondView: View {
    @StateObject private var viewModel = SecondViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                UIKitLabel(text: viewModel.message, color: .black, size: 40)
                
                //  Для оставления пространства между кнопками и label
                Spacer()
                
                //  Lazy - позволяет в данном случае сэкономить ресурсы, так как будет отрисовывать только те элементы, которые в пределах экрана.
                //  Ставим spacing между рядами (сверху снизу)
                LazyVGrid(columns: viewModel.columns, spacing: 8) {
                    //  Расставляем каждую кнопку с помощью цикла
                    ForEach(viewModel.buttons, id: \.self) { button in
                        UIKitButton(text: button, size: 40) {
                            viewModel.tapOnButton(button)
                        }
                        //  Делаем кнопки квадратной формы
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding()
            }
            .navigationDestination(isPresented: $viewModel.showThirdView) {
                ThirdView()
            }
        }
    }
}

#Preview {
    SecondView()
}
