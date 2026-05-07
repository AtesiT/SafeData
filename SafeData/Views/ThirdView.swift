import SwiftUI
import UniformTypeIdentifiers

struct ThirdView: View {
    @StateObject private var viewModel = ThirdViewModel()
    
    var body: some View {
        //  Для создания заголовка и возможности делать переходы
        NavigationView {
            List {
                //  Через цикл расставляем наши файлы списком
                ForEach(viewModel.ourFiles) { file in
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
                .onDelete { index in
                    viewModel.fileDelete(at: index)
                }
            }
            .navigationTitle("File Manager")
            .toolbar {
                Button(action: { viewModel.showImportWindow = true }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                }
            }
            .fileImporter(
                isPresented: $viewModel.showImportWindow,
                allowedContentTypes: [.item],
                allowsMultipleSelection: false
            ) { result in
                viewModel.fileImport(result: result)
            }
        }
    }
}

#Preview {
    ThirdView()
}
