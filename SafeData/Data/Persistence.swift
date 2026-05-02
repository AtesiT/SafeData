import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        //  Должно совпадать с названием файла DataModel
        container = NSPersistentContainer(name: "Users")
        
        //  Создание или подключение уже существующей БД
        container.loadPersistentStores { (NSPersistentStoreDescription, error) in
            if let error = error as NSError? {
                fatalError("Ошибка: \(error) \(error.userInfo)")
            }
        }
        //  Для автоматического изменения данных
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
