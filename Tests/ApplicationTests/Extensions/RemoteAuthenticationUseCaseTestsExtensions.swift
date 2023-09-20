import Foundation
import Application
import Domain
import Shared

extension RemoteAuthenticationUseCaseTests {
    func createSUT(url: URL = URL(string: "https://any_url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (RemoteAuthenticationUseCase, HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        @Provider var httpPostClientProtocol = WeakVarProxy(httpClientSpy) as HttpPostClientProtocol

        let sut = RemoteAuthenticationUseCase(url: url)

        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)

        return (sut, httpClientSpy)
    }
}
