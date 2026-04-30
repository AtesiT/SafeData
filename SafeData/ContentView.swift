import SwiftUI

struct ContentView: View {
    @State private var inputUsername: String = ""
    @State private var inputPassword: String = ""
    
    var body: some View {
        Text("Добро пожаловать!")
        
        HStack {
            Image(systemName: "person.crop.circle")
                .foregroundStyle(Color.gray)
            TextField("Введите имя пользователя", text: $inputUsername)
                .textFieldStyle(.roundedBorder)

        }
        .padding(.horizontal, 64)
        
        HStack {
            Image(systemName: "lock.fill")
                .foregroundStyle(Color.gray)
            TextField("Введите пароль", text: $inputUsername)
                .textFieldStyle(.roundedBorder)

        }
        .padding(.horizontal, 64)
    }
}

#Preview {
    ContentView()
}
