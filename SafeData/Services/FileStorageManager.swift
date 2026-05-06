import Combine
import SwiftUI

//  FileManager - системный объект, который может создавать папки, перемещать, копировать, или удалять файлы

//  Протокол ObservableObject - отправляет экранам (у которого наш класс есть) уведомление о том, что наш класс изменился
class FileStorageManager: ObservableObject {
    //  Наш массив с файлами (он подписан под @Published, чтобы если свойство обновилось, то можно было сразу обновить класс)
    @Published var ourFiles: [AppFile] = []
    
    private var documentsDirectory: URL {
        //  Получаем путь к папке документов этого приложения для нашего пользователя
        //  Нам вернётся массив путей, поэтому берём первый элемент
        //  Наш "сейф"
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    init() {
        loadFiles()
    }
    
    func loadFiles() {
        do {
            //  Получаем список всех URL к нашим файлам
            let urlWithContent = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            //  Конвертирование URL системных файлов в объекты AppFile
            self.ourFiles = urlWithContent.map { url in
                AppFile(name: url.lastPathComponent, url: url)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveFile(from sourceURL: URL) {
        //  sourceURL - хранит путь к файлу, что был выбран
        //  lastPathComponent - имя файда с расширением
        //  appendingPathComponent - позволяет, добавить к documentsDirectory путь. В итоге, получим полный путь вместе с путём к папке документов приложения (сейф) и названием файла
        let destinationURL = documentsDirectory.appendingPathComponent(sourceURL.lastPathComponent)
        
        
        //  Используем конструкцию do-catch, так как файл может существовать уже или места не хватает на устройстве
        do {
            //  Если файл уже существует, то удаляеи старую версию файла (перезапись)
            //  Без этих строк бы система выдала ошибку, если файл существовал. Так как, мы пытались бы вставить файл в то же самое место, которое уже занято.
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                try FileManager.default.removeItem(at: destinationURL)
            }
            
            //  Копирование файла в наше хранилище "сейф"
            //  Берёт файл из sourceURL и копирует в destinationURL
            try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
            
            //  Обновление интерфейса, так как необходимо показать его в списке файлов
            let newFile = AppFile(name: sourceURL.lastPathComponent, url: destinationURL)
            ourFiles.append(newFile)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteFile(at offsets: IndexSet) {
        //  Проходим по индексам
        offsets.forEach { index in
            //  Берём нужный нам файл
            let file = ourFiles[index]
            
            do {
                //  Удаляем файл физически
                try FileManager.default.removeItem(at: file.url)
            } catch {
                print(error.localizedDescription)
            }
        }
        //  После того, как наш объект удалён физически, мы удаляем элемент из массива
        ourFiles.remove(atOffsets: offsets)
    }
}
