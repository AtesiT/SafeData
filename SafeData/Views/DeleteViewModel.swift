import SwiftUI
import Combine
import CoreData

class DeleteViewModel: ObservableObject {
    
    @Published var inputUsername: String = ""
    @Published var inputPassword: String = ""
    
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    private let viewContext: NSManagedObjectContext
    
    //  Передаём через инициализатор, т.к. @Environment не используется в классах и не сможет самостоятельно инициализироваться (данная обёртка использутся для структур под протоколом View)
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
}

extension DeleteViewModel {
    func deleteUser() {
        //  Присваиваем переменные
        let correctUsername = inputUsername.trimmingCharacters(in: .whitespaces)
        let correctPassword = hashInfo(inputPassword.trimmingCharacters(in: .whitespaces))
        
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
                
                self.alertMessage = "Пользователь успешно удалён"
                self.showAlert = true
                self.inputUsername = ""
                self.inputPassword = ""
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Такого пользователя не существует")
        }
    }
}
