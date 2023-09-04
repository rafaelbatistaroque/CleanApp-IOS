import XCTest
import Domain
import Application

final class RemoteAddAccountUseCaseTests: XCTestCase {
    func test_givenAddAccount_whenCallsHttpPostClient_thenMustBePassingCorrectUrl() async {
        //arrange
        let expectedRemoteUrl = URL(string: "https://any_url.com")!
        let (sut, httpClientSpy) = createSUT(url: expectedRemoteUrl)
        
        //act
        let _ = await sut.handle(input: fakeAddAccountInputValid())
        
        //asset
        XCTAssertEqual([expectedRemoteUrl], httpClientSpy.urls)
    }
    
    func test_givenAddAccount_whenCallsHttpPostClient_thenMustBePassingCorrectData() async{
        //arrange
        let (sut, httpClientSpy) = createSUT()
        let input = fakeAddAccountInputValid()
        let expectedContent = input.toData();
        
        //act
        let _ = await sut.handle(input: input)
        
        //asset
        XCTAssertEqual(expectedContent, httpClientSpy.content)
    }
    
    func test_givenAddAccount_whenFailsHttpPostClient_thenMustBeReturnResultError() async {
        //arrange
        let (sut, httpClientSpy) = createSUT()
        httpClientSpy.setupFailure(erro: HttpError.noConnectivity)
        
        //act
        let result = await sut.handle(input: fakeAddAccountInputValid())
       
        //asset
        XCTAssertEqual(.unexpected, result)
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
        var urls = [URL]()
        var content: Data?
        var callsCount: Int = 0
        var isFailure: Bool = false
        var result: Result<Data, HttpError> = .failure(HttpError.any)
        
        func post(to url: URL, with content: Data?) async -> Result<Data, HttpError> {
            self.urls.append(url)
            self.content = content
            
            return result
        }

        func setupFailure(erro: HttpError){
            isFailure = true
            self.result = .failure(erro)
        }
        
        func setupSuccess(data: Data){
            isFailure = true
            self.result = .success(data)
        }
    }
}
