import SwiftUI

struct DeleteView: View {
    @State private var inputUsername: String = ""
    @State private var inputPassword: String = ""
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Удаление аккаунта")
            TextField("Введите имя пользователя", text: $inputUsername)
            TextField("Введите пароль", text: $inputPassword)
            Button("Удалить аккаунт") {
                print("Test")
            }
        }
    }
}

#Preview {
    DeleteView()
}
