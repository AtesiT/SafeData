import SwiftUI

struct ContentView: View {
    //  Переключатель для того, чтобы перейти на второй экран
    @State private var showSecondView: Bool = false
    
    @State private var inputUsername: String = ""
    @State private var inputPassword: String = ""
    
    var body: some View {
        //  Необходим NavigationStack для того, чтобы можно было осуществлять переход
        NavigationStack {
            //  Без VStack могут не работать кнопки (визуально будут отображаться,  но нажатия фиксироваться корректно не будут)
            VStack {
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
                    TextField("Введите пароль", text: $inputPassword)
                        .textFieldStyle(.roundedBorder)
                    
                }
                .padding(.horizontal, 64)
                
                Button("Войти") {
                    signIn()
                }
            }
            .padding(8)
            //  Добавляем переход на второй экран
            .navigationDestination(isPresented: $showSecondView) {
                SecondView()
            }
        }
    }
}

extension ContentView {
    //  Функция для перехода на второй экран
    private func signIn() {
        if (inputUsername == "user") && (inputPassword == "password") {
            showSecondView = true
        }
    }
}

#Preview {
    ContentView()
}
