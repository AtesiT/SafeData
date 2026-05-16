import SwiftUI
import Combine

class DeleteViewModel: ObservableObject {
    
    @Published var inputUsername: String = ""
    @Published var inputPassword: String = ""
}
