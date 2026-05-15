import SwiftUI
import CoreData

struct EditView: View {
    @Environment(\.managedObjectContext) private var viewContext
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
                TextField("Введите новое имя", text: $newUsername)
                TextField("Введите новый пароль", text: $newPassword)
            }
            Button("Изменить данные") {
                editUser()
            }
        }
    }
}

extension EditView {
    private func editUser() {
        //  Присваиваем переменные
        let correctUsername = inputUsername.trimmingCharacters(in: .whitespaces)
        let correctPassword = hashInfo(inputPassword.trimmingCharacters(in: .whitespaces))
        let newCorrectUsername = newUsername.trimmingCharacters(in: .whitespaces)
        let newCorrectPassword = hashInfo(newPassword.trimmingCharacters(in: .whitespaces))
        
        //  Запрос к базе данных
        let request = NSFetchRequest<User>(entityName: "User")
        
        //  Фильтруем
        request.predicate = NSPredicate(format: "username == %@ AND password == %@", correctUsername, correctPassword)
        //  Возвращение только одного результата
        request.fetchLimit = 1
        
        //  Присваиваем данные
        let result = (try? viewContext.fetch(request)) ?? []
        
        if let theUser = result.first {
            //  Присваиваем новые данные пользователю
            theUser.username = newCorrectUsername
            theUser.password = newCorrectPassword
            
            //  Если БД была изменена, то оповещаем и сохраняем новые данные
            if viewContext.hasChanges {
                do {
                    try viewContext.save()
                    print("Данные пользователя были изменены")
                } catch {
                    print(error.localizedDescription)
                }
            }
        } else {
            print("Ошибка")
        }
    }
}

#Preview {
    EditView()
}
