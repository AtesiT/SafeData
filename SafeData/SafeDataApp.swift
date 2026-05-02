import SwiftUI
import CoreData

@main
struct SafeDataApp: App {
    //  Создание экземпляра для управления БД
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //  Environment - передача данных потомкам (вместо того, чтобы вручную в каждом файле прописывать доступ к БД)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
