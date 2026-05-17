import SwiftUI
import Combine
import CoreData

class EditViewModel: ObservableObject {
    //  Переменные, которые будут использоваться
    @Published var inputUsername: String = ""
    @Published var inputPassword: String = ""
    //  Будут хранится новые данные пользователя
    @Published var newUsername: String = ""
    @Published var newPassword: String = ""
    
    @Published var alertMessage = ""
    @Published var showAlert = false

    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
}

extension EditViewModel {
    func editUser() {
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
                    self.alertMessage = "Данные пользователя успешно отредактированы"
                    self.showAlert = true
                    self.inputUsername = ""
                    self.inputPassword = ""
                } catch {
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        } else {
            print("Ошибка")
        }
    }
}
