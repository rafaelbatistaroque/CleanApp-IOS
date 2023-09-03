import XCTest

final class RemoteAddAccountUseCaseTests: XCTestCase {
    func test_givenAddAccount_whenHttpPostClient_thenMustBePassingCorrectUrl(){
        //arrange
        let expectedRemoteUrl = URL(string: "https://any_url.com")
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccountUseCase(url: expectedRemoteUrl!, httpClient: httpClientSpy)
        
        //act
        sut.handle()

        //asset
        XCTAssertEqual(expectedRemoteUrl, httpClientSpy.url)
    }
}

protocol HttpPostClientProtocol{
    func post(url: URL)
}

class RemoteAddAccountUseCase{
    private let url: URL
    private let httpClient: HttpPostClientProtocol
    
    init(url: URL, httpClient: HttpPostClientProtocol) {
        self.url = url
        self.httpClient = httpClient
    }
     
    func handle(){
        self.httpClient.post(url: self.url)
    }
}

extension RemoteAddAccountUseCaseTests {
 
    class HttpClientSpy: HttpPostClientProtocol{
        var url: URL?
        
        func post(url: URL) {
            self.url = url
        }
    }

}
