import SwiftUI
import Combine

class EditViewModel: ObservableObject {
    //  Переменные, которые будут использоваться
    @Published var inputUsername: String = ""
    @Published var inputPassword: String = ""
    //  Будут хранится новые данные пользователя
    @Published var newUsername: String = ""
    @Published var newPassword: String = ""

}
