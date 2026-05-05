import UIKit
import SwiftUI

struct UIKitLabel: UIViewRepresentable {
    //  Получение текста из SwiftUI здесь
    var text: String
    var color: UIColor = .systemBlue
    var size: CGFloat = 14
    
    //  Создание нашего Label (вызывается один раз)
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
//        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: size)
        return label
    }
    
    //  Присваивание текста в Label (вызывается при обновлении)
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
        uiView.textColor = color
    }
}

#Preview {
    UIKitLabel(text: "Hello")
}
