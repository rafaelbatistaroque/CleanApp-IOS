import Foundation
import Application
import Domain

extension RemoteAddAccountUseCaseTests {
    func fakeAddAccountInputValid() -> AddAccountInput{
        AddAccountInput(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_password")
    }

    func createSUT(url: URL = URL(string: "https://any_url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (RemoteAddAccountUseCase, HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccountUseCase(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)

        return (sut, httpClientSpy)
    }
}
