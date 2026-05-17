import SwiftUI
import CoreData

//  MARK: - VALUABLES

struct ContentView: View {
    //  Создаём свойство для того, чтобы получить доступ к базе данным
    @Environment(\.managedObjectContext) private var viewContext
    //  Переключатель для того, чтобы перейти на какой-либо из экранов
    @State private var showSecondView: Bool = false
    @State private var showDeleteView: Bool = false
    @State private var showEditView: Bool = false
    //  Переключатель для показа alert и сообщение для показа в alert
    @State private var showAlert: Bool = false
    @State private var showAlertMessage: String = ""
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
                            .textFieldModifier(width: 320)
                            
                    }
                    .padding(.horizontal, 64)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundStyle(Color.gray)
                        SecureField("Введите пароль", text: $inputPassword)
                            .secureFieldModifier(width: 320)
                        
                    }
                    .padding(.horizontal, 64)
                    
                    //  Кнопки
                    
                    //  Первая кнопка
                    Button("Войти") {
                        signIn()
                    }
                    .disabled(inputUsername.isEmpty || inputPassword.isEmpty)
                    
                    //  Вторая кнопка
                    Button("Регистрация") {
                        signUp()
                    }
                    .disabled(inputUsername.isEmpty || inputPassword.isEmpty)
                    
                    Button("Перейти на экран удаления") {
                        deleteUser()
                    }
                    Button("Перейти на экран изменения") {
                        editUser()
                    }
                }
                .padding(8)
                .alert("Ошибка", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(showAlertMessage)
                }
                //  Добавляем переход на второй экран
                .navigationDestination(isPresented: $showSecondView) {
                    SecondView()
                }
                .navigationDestination(isPresented: $showDeleteView) {
                    DeleteView()
                }
                .navigationDestination(isPresented: $showEditView) {
                    EditView()
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
                    user.username = "Tim"
                    user.password = "Cook"
                    
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
        let correctPassword = hashInfo(inputPassword.trimmingCharacters(in: .whitespaces))
        
        //  Запрос к БД для поиска в Entity под названием User
        let request = NSFetchRequest<User>(entityName: "User")
        print(correctPassword)
        //  Просим БД отфильтровать по условиям
        request.predicate = NSPredicate(format: "username == %@ AND password == %@", correctUsername, correctPassword)
        
        //  Если данные подходили по условиям, то они хравнятся в request, присваиваем найденное в result
        let result = (try? viewContext.fetch(request)) ?? []
        
        if !result.isEmpty {
            backgroundColor = .green
            showSecondView = true
        } else {
            backgroundColor = .red
            showAlertMessage = "Вы ввели неправильные данные или такого пользователя не существует"
            showAlert = true
            inputPassword = ""
        }
    }
    //  Для регистрации пользователя
    private func signUp() {
        let correctUsername = inputUsername.trimmingCharacters(in: .whitespaces)
        let correctPassword = hashInfo(inputPassword.trimmingCharacters(in: .whitespaces))
        
        let request = NSFetchRequest<User>(entityName: "User")
        
        request.predicate = NSPredicate(format: "username == %@ OR password == %@", inputUsername, inputPassword)
        
        let result = (try? viewContext.fetch(request)) ?? []
        
        if result.isEmpty {
            //  Создание пользователя для базы данных и присваивание данных
            let newUser = User(context: viewContext)
            newUser.id = UUID()
            newUser.username = correctUsername
            newUser.password = correctPassword
            
            //  Сохранение пользователя в базе данных
            try? viewContext.save()
            
            backgroundColor = .yellow
            
            showAlertMessage = "Вы успешно зарегистрированы"
            showAlert = true
        } else {
            showAlertMessage = "Такой пользователь уже существует"
            showAlert = true
        }
    }
    //  Для перехода на экран удаления
    private func deleteUser() {
        showDeleteView = true
    }
    //  Для перезода на экран редактирования пользователя
    private func editUser() {
        showEditView = true
    }
}


//  MARK: - PREVIEW

#Preview {
    ContentView()
        //  Передаём данные из БД
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
