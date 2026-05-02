import SwiftUI
import CoreData

//  MARK: - VALUABLES

struct ContentView: View {
    //  Создаём свойство для того, чтобы получить доступ к базе данным
    @Environment(\.managedObjectContext) private var viewContext
    //  Переключатель для того, чтобы перейти на второй экран
    @State private var showSecondView: Bool = false
    //  Переключатель для показа alert
    @State private var showAlert: Bool = false
    //  Цвет заднего фона
    @State private var backgroundColor: Color = .clear
    //  Данные пользователей
    @State private var inputUsername: String = ""
    @State private var inputPassword: String = ""
    
    //  MARK: - THE VIEW
    
    var body: some View {
        //  Необходим NavigationStack для того, чтобы можно было осуществлять переход
        NavigationStack {
            //  Устанавливаем ZStack, чтобы установить цвет фона
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                    .animation(.default, value: backgroundColor)
                //  Без VStack могут не работать кнопки (визуально будут отображаться,  но нажатия фиксироваться корректно не будут)
                VStack {
                    Text("Добро пожаловать!")
                    
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .foregroundStyle(Color.gray)
                        TextField("Введите имя пользователя", text: $inputUsername)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }
                    .padding(.horizontal, 64)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundStyle(Color.gray)
                        SecureField("Введите пароль", text: $inputPassword)
                            .textFieldStyle(.roundedBorder)
                        
                    }
                    .padding(.horizontal, 64)
                    
                    Button("Войти") {
                        signIn()
                    }
                    .disabled(inputUsername.isEmpty || inputPassword.isEmpty)
                    .alert("Ошибка", isPresented: $showAlert) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text("Вы ввели неправильные данные")
                    }
                }
                .padding(8)
                //  Добавляем переход на второй экран
                .navigationDestination(isPresented: $showSecondView) {
                    SecondView()
                }
            }
            .onAppear {
                //  Запрос к БД
                let request = NSFetchRequest<User>(entityName: "User")
                
                //  Быстрее будет узнать число, нежели брать данные
                if (try? viewContext.count(for: request)) ?? 0 == 0 {
                    //  Если данных окажется 0, то создаём пользователя с таким именем и фамилией
                    let user = User(context: viewContext)
                    user.id = UUID()
                    user.name = "Tim"
                    user.surname = "Cook"
                    
                    //  Сохраняем в БД
                    try? viewContext.save()
                }
            }
        }
    }
}

//  MARK: - FUNCTIONS

extension ContentView {
    //  Функция для перехода на второй экран
    private func signIn() {
        let correctUsername = inputUsername.trimmingCharacters(in: .whitespaces)
        let correctPassword = inputPassword.trimmingCharacters(in: .whitespaces)
        
        //  Запрос к БД для поиска в Entity под названием User
        let request = NSFetchRequest<User>(entityName: "User")
        
        //  Просим БД отфильтровать по условиям
        request.predicate = NSPredicate(format: "name == %@ AND surname == %@", correctUsername, correctPassword)
        
        //  Если данные подходили по условиям, то они хравнятся в request, присваиваем найденное в result
        let result = (try? viewContext.fetch(request)) ?? []
        
        if !result.isEmpty {
            backgroundColor = .green
            showSecondView = true
        } else {
            backgroundColor = .red
            showAlert = true
            inputPassword = ""
        }
    }
}

#Preview {
    ContentView()
}
