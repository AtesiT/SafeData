import UIKit
import SwiftUI

struct UIKitButton: UIViewRepresentable {
    //  Текст, который будем передавать кнопке
    var text: String
    var color: UIColor = .systemBlue
    var size: CGFloat = 14
    var action: (() -> Void)?
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //  Срабатывает один раз
    func makeUIView(context: Context) -> UIButton {
        let button = UIButton(type: .system)
        //  Добавление действия для кнопки
        //  После нажатия на кнопку, переходит в координатор и вызывает метод tap
        button.addTarget(
            context.coordinator,
            action: #selector(Coordinator.tap),
            for: .touchUpInside
        )
        button.titleLabel?.font = UIFont.systemFont(ofSize: size)
        return button
    }
    
    //  При обновлении
    func updateUIView(_ uiView: UIButton, context: Context) {
        uiView.setTitle(text, for: .normal)
        uiView.setTitleColor(color, for: .normal)
        //  Когда SwiftUI перерисовывает наш view, мы передаем координатору новую версию нашей структуры (включая action)
        context.coordinator.parent = self
    }
    
    class Coordinator: NSObject {
        var parent: UIKitButton
        
        init(_ parent: UIKitButton) {
            self.parent = parent
        }
        
        @objc func tap() {
            parent.action?()
        }
    }
}

#Preview {
    UIKitButton(text: "Tap me!", color: .black) {
        print("Tap")
    }
}
