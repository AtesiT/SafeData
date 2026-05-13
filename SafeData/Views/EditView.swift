import SwiftUI

struct EditView: View {
    //  Хранятся старые данные в этих переменных
    @State private var inputUsername: String = ""
    @State private var inputPassword: String = ""
    //  Будут хранится новые данные пользователя
    @State private var newUsername: String = ""
    @State private var newPassword: String = ""
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Старые данные")
            VStack {
                TextField("Введите имя", text: $inputUsername)
                TextField("Введите пароль", text: $inputPassword)
            }
            Text("Новые данные")
            VStack {
                TextField("Введите новое имя", text: $inputUsername)
                TextField("Введите новый пароль", text: $inputPassword)
            }
            Button("Изменить данные") {
                print("Test")
            }
        }
    }
}

#Preview {
    EditView()
}
