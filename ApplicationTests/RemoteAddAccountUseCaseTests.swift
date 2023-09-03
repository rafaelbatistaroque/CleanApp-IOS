import XCTest
import Domain

final class RemoteAddAccountUseCaseTests: XCTestCase {
    func test_givenAddAccount_whenHttpPostClient_thenMustBePassingCorrectUrl(){
        //arrange
        let httpClientSpy = HttpClientSpy()
        let expectedRemoteUrl = URL(string: "https://any_url.com")
        let sut = createSUT(withHttpClient: httpClientSpy, withUrl: expectedRemoteUrl)
        
        //act
        sut.handle(input: fakeInputValid())

        //asset
        XCTAssertEqual(expectedRemoteUrl, httpClientSpy.url)
    }
    
    func test_givenAddAccount_whenHttpPostClient_thenMustBePassingCorrectData(){
        //arrange
        let httpClientSpy = HttpClientSpy()
        let sut = createSUT(withHttpClient: httpClientSpy)
        let input = fakeInputValid()
        let expectedContent = try? JSONEncoder().encode(input);
        
        
        //act
        sut.handle(input: input)

        //asset
        XCTAssertEqual(expectedContent, httpClientSpy.content)
    }
}

extension RemoteAddAccountUseCaseTests {
    
    func fakeInputValid() -> AddAccountInput{
        return AddAccountInput(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_password")
    }
    
    func createSUT(withHttpClient: HttpPostClientProtocol, withUrl:URL? = URL(string: "https://any_url.com")) -> RemoteAddAccountUseCase{
        return RemoteAddAccountUseCase(url: withUrl!, httpClient: withHttpClient)
    }
    
    class HttpClientSpy: HttpPostClientProtocol{
        var url: URL?
        var content: Data?
        
        func post(to url: URL, with content: Data?) {
            self.url = url
            self.content = content
        }
    }

}

protocol HttpPostClientProtocol{
    func post(to url: URL, with content: Data?)
}

class RemoteAddAccountUseCase{
    private let url: URL
    private let httpClient: HttpPostClientProtocol
    
    init(url: URL, httpClient: HttpPostClientProtocol) {
        self.url = url
        self.httpClient = httpClient
    }
     
    func handle(input: AddAccountInput){
        let content = try? JSONEncoder().encode(input);
        self.httpClient.post(to: self.url, with: content)
    }
}
