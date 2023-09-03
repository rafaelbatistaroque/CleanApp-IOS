import XCTest
import Domain

final class RemoteAddAccountUseCaseTests: XCTestCase {
    func test_givenAddAccount_whenHttpPostClient_thenMustBePassingCorrectUrl(){
        //arrange
        let expectedRemoteUrl = URL(string: "https://any_url.com")!
        let (sut, httpClientSpy) = createSUT(url: expectedRemoteUrl)
        
        //act
        sut.handle(input: fakeAddAccountInputValid())
        
        //asset
        XCTAssertEqual(expectedRemoteUrl, httpClientSpy.url)
    }
    
    func test_givenAddAccount_whenHttpPostClient_thenMustBePassingCorrectData(){
        //arrange
        let (sut,httpClientSpy) = createSUT()
        let input = fakeAddAccountInputValid()
        let expectedContent = try? JSONEncoder().encode(input);
        
        //act
        sut.handle(input: input)
        
        //asset
        XCTAssertEqual(expectedContent, httpClientSpy.content)
    }
}

extension RemoteAddAccountUseCaseTests {
    
    func fakeAddAccountInputValid() -> AddAccountInput{
        return AddAccountInput(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_password")
    }
    
    func createSUT(url: URL = URL(string: "https://any_url.com")!) -> (sut: RemoteAddAccountUseCase, httpClient: HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccountUseCase(url: url, httpClient: httpClientSpy)

        return (sut, httpClientSpy)
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
        self.httpClient.post(to: self.url, with: input.toData())
    }
}
