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
        }
    }
}

#Preview {
    ThirdView()
}
