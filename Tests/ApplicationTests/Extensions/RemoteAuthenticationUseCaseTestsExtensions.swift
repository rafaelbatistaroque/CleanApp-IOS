import Foundation
import Application
import Domain
import Shared

extension RemoteAuthenticationUseCaseTests {
    func fakeAuthenticationInputValid() -> AuthenticationInput{
        AuthenticationInput(email: "test@email.com", password: "any_password")
    }

    func fakeAuthenticationInputInvalidWith(email:String? = "test@email.com", password:String? = "any_password") -> AuthenticationInput{
        AuthenticationInput(email: email, password: password)
    }

    func createSUT(url: URL = URL(string: "https://any_url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (RemoteAuthenticationUseCase, HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        @Provider var httpPostClientProtocol = WeakVarProxy(httpClientSpy) as HttpPostClientProtocol

        let sut = RemoteAuthenticationUseCase(url: url)

        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)

        return (sut, httpClientSpy)
    }
}
