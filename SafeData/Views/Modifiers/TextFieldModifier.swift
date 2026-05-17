import SwiftUI

struct TextFieldModifier: ViewModifier {
    let width: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: width)
            .padding(4)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
        //  Добавление внутреннего отступа, без него текстовое поле выглядит меньше по размерам
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.1), lineWidth: 1)
            }
//            .textFieldStyle(.roundedBorder)
//            .cornerRadius(8)
    }
}

extension TextField {
    func textFieldModifier(width: CGFloat) -> some View {
        self.modifier(TextFieldModifier(width: width))
    }
}

extension SecureField {
    func secureFieldModifier(width: CGFloat) -> some View {
        self.modifier(TextFieldModifier(width: width))
    }
}
