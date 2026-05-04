import UIKit
import SwiftUI

struct UIKitLabel: UIViewRepresentable {
    //  Получение текста из SwiftUI здесь
    var text: String
    
    //  Создание нашего Label (вызывается один раз)
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemBlue
        return label
    }
    
    //  Присваивание текста в Label (вызывается при обновлении)
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
    }
}

#Preview {
    UIKitLabel(text: "Hello")
}
