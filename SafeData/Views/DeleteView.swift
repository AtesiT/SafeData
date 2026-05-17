import SwiftUI
import CoreData

struct DeleteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    //  Передаем с помощью init, так как до этого в момент инициализации переменная будет nil
    @StateObject private var viewModel: DeleteViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: DeleteViewModel(viewContext: PersistenceController.shared.container.viewContext))
    }
        
    var body: some View {
        VStack(spacing: 15) {
            Text("Удаление аккаунта")
            TextField("Введите имя пользователя", text: $viewModel.inputUsername)
            SecureField("Введите пароль", text: $viewModel.inputPassword)
            Button("Удалить аккаунт") {
                viewModel.deleteUser()
            }
        }
        .alert("Вывод", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

#Preview {
    DeleteView()
}
