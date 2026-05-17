import SwiftUI
import CoreData

struct EditView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject private var viewModel: EditViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: EditViewModel(viewContext: PersistenceController.shared.container.viewContext))
    }
    
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
                viewModel.editUser()
            }
        }
        .alert("Вывод", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

#Preview {
    EditView()
}
