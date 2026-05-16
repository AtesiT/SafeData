import SwiftUI
import CoreData

struct DeleteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject private var viewModel = DeleteViewModel()
        
    var body: some View {
        VStack(spacing: 15) {
            Text("Удаление аккаунта")
            TextField("Введите имя пользователя", text: $viewModel.inputUsername)
            SecureField("Введите пароль", text: $viewModel.inputPassword)
            Button("Удалить аккаунт") {
                deleteUser()
            }
        }
    }
}

extension DeleteView {
    func deleteUser() {
        //  Присваиваем переменные
        let correctUsername = viewModel.inputUsername.trimmingCharacters(in: .whitespaces)
        let correctPassword = hashInfo(viewModel.inputPassword.trimmingCharacters(in: .whitespaces))
        
        //  Создаём запрос к базе данных в Entity по названию "User"
        let request = NSFetchRequest<User>(entityName: "User")
        
        //  Отфильтровываем по условию
        request.predicate = NSPredicate(format: "username == %@ AND password == %@", correctUsername, correctPassword)
        
        //  Примваиваем данные (если были) в result
        let result = (try? viewContext.fetch(request)) ?? []
        
        if let theUser = result.first {
            viewContext.delete(theUser)
            
            do {
                try viewContext.save()
                print("Пользователь был удалён")
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Такого пользователя не существует")
        }
    }
}

#Preview {
    DeleteView()
}
