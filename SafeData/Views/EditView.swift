import SwiftUI
import CoreData

struct EditView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject private var viewModel = EditViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Старые данные")
            VStack {
                TextField("Введите имя", text: $viewModel.inputUsername)
                SecureField("Введите пароль", text: $viewModel.inputPassword)
            }
            Text("Новые данные")
            VStack {
                TextField("Введите новое имя", text: $viewModel.newUsername)
                SecureField("Введите новый пароль", text: $viewModel.newPassword)
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
        let correctUsername = viewModel.inputUsername.trimmingCharacters(in: .whitespaces)
        let correctPassword = hashInfo(viewModel.inputPassword.trimmingCharacters(in: .whitespaces))
        let newCorrectUsername = viewModel.newUsername.trimmingCharacters(in: .whitespaces)
        let newCorrectPassword = hashInfo(viewModel.newPassword.trimmingCharacters(in: .whitespaces))
        
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
