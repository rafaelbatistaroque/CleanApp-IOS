import Foundation
import Application
import Domain
import Shared

extension RemoteAddAccountUseCaseTests {
    func fakeAddAccountInputValid() -> AddAccountInput{
        AddAccountInput(name: "any_name", email: "test@email.com", password: "any_password", passwordConfirmation: "any_password")
    }

    func fakeAddAccountInputInvalidWith(name:String? = "any_name", email:String? = "test@email.com", password:String? = "any_password", passwordConfirmation:String? = "any_password") -> AddAccountInput{
        AddAccountInput(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }

    func createSUT(url: URL = URL(string: "https://any_url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (RemoteAddAccountUseCase, HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        @Provider var httpPostClientProtocol = WeakVarProxy(httpClientSpy) as HttpPostClientProtocol

        let sut = RemoteAddAccountUseCase(url: url)

        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)

        return (sut, httpClientSpy)
    }
}
