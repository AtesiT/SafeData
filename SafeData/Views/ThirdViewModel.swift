import SwiftUI
import Combine

class ThirdViewModel: ObservableObject {
    //  Менеджер сохранения файлов
    @StateObject var manager = FileStorageManager()
    //  Показывать окно импорта файлов
    @State var showImportWindow = false
    //  Доступ к списку файлов
    var ourFiles: [AppFile] {
        manager.ourFiles
    }
    
    func fileImport(result: Result<[URL], Error>) {
        switch result {
            //  При успехе, нам вернется массив url
        case .success(let urls):
            //  Берём первый элемент из массива url
            guard let url = urls.first else { return }
            //  Обращаемся по url, используем метод startAccessingSecurityScopedResource, с помощью которого мы даём нашему приложению прочитать какой-либо файл
            if url.startAccessingSecurityScopedResource() {
                //  Сохранене файла
                manager.saveFile(from: url)
                //  Для предотвращения утечек и утечек памяти\лимита файлов
                url.stopAccessingSecurityScopedResource()
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func fileDelete(at offsets: IndexSet) {
        manager.deleteFile(at: offsets)
    }
}
