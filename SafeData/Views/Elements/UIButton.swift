import UIKit
import SwiftUI

struct UIKitButton: UIViewRepresentable {
    //  Текст, который будем передавать кнопке
    var text: String
    var color: UIColor = .systemBlue
    
    //  Срабатывает один раз
    func makeUIView(context: Context) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(color, for: .normal)
        return button
    }
    
    //  При обновлении
    func updateUIView(_ uiView: UIButton, context: Context) {
    }
}

#Preview {
    UIKitButton(text: "Tap me!", color: .black)
}
