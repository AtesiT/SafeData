import XCTest
@testable import SafeData

final class PasswordHashingTests: XCTestCase {
    
    func testHashingPassword() {
        //  Придумываем пароль
        let password = "password"
        //  Используем нашу функцию для хэширования пароля дважды
        //  Результаты должны совпасть, потому что одна и та же функция
        let firstPassword = hashInfo(password)
        let secondPassword = hashInfo(password)
        //  Проверяем, что результаты совпали
        XCTAssertEqual(firstPassword, secondPassword, "Результаты должны быть схожи")
    }
}
