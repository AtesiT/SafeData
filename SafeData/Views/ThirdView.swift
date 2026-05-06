import SwiftUI
import UniformTypeIdentifiers

struct ThirdView: View {
    //  Менеджер сохранения файлов
    @StateObject private var manager = FileStorageManager()
    //  Показывать окно импорта файлов
    @State private var showImportWindow = false
    
    var body: some View {
        //  Для создания заголовка и возможности делать переходы
        NavigationView {
            List {
                //  Через цикл расставляем наши файлы списком
                ForEach(manager.ourFiles) { file in
                    //  Делаем слева иконку приложения, названия файла, пустое пространство и справа кнопку, чтобы можно было загрузить
                    HStack {
                        Image(systemName: "doc.fill")
                            .foregroundStyle(.black)
                        
                        Text(file.name)
                        
                        Spacer()
                        
                        ShareLink(item: file.url) {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                }
            }
            .navigationTitle("File Manager")
            .toolbar {
                Button(action: { showImportWindow = true }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                }
            }
            .fileImporter(
                //  Если true, то откроется окно добавления файлов
                isPresented: $showImportWindow,
                //  Тип файлов (.item - любой тип файлов)
                allowedContentTypes: [.item],
                //  Выбираем один файл за раз
                allowsMultipleSelection: false) { result in
                    switch result {
                    //  При успехе, нам вернется массив url
                    case .success(let urls):
                        //  Берём первый элемент из массива url
                        if let url = urls.first {
                            //  Обращаемся по url, используем метод startAccessingSecurityScopedResource, с помощью которого мы даём нашему приложению прочитать какой-либо файл
                            if url.startAccessingSecurityScopedResource() {
                                //  Сохранене файла
                                manager.saveFile(from: url)
                                //  Для предотвращения утечек и утечек памяти\лимита файлов
                                url.stopAccessingSecurityScopedResource()
                            }
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        }
    }
}

#Preview {
    ThirdView()
}
