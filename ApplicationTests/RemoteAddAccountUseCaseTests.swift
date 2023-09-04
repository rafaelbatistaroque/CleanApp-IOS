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
        XCTAssertEqual(expectedContent, httpClientSpy.inputData)
    }
    
    func test_givenAddAccount_whenNoConnectivityFailsHttpPostClient_thenMustBeReturnResultUnexpectedError() async {
        //arrange
        let (sut, httpClientSpy) = createSUT()
        httpClientSpy.setupResult(result: .noConnectivity)
        
        //act
        let result = await sut.handle(input: fakeAddAccountInputValid())
       
        //asset
        XCTAssertEqual(Result.failure(.unexpected), result)
    }
    
    func test_givenAddAccount_whenSuccessHttpPostClient_thenMustBeReturnResultUnexpectedData() async {
        //arrange
        let (sut, httpClientSpy) = createSUT()
        let expectedAccountOutput = createAddAccountOutput();
        httpClientSpy.setupResult(result: expectedAccountOutput.toData()!)
        
        //act
        let result = await sut.handle(input: fakeAddAccountInputValid())
       
        //asset
        XCTAssertEqual(Result.success(expectedAccountOutput), result)
    }
}

extension RemoteAddAccountUseCaseTests {
    
    func fakeAddAccountInputValid() -> AddAccountInput{
        return AddAccountInput(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_password")
    }
    
    func createAddAccountOutput() -> AddAccountOutput{
        return AddAccountOutput(id: "any_id", name: "any_name", email: "any_email", password: "any_password")
    }

    func createSUT(url: URL = URL(string: "https://any_url.com")!) -> (sut: RemoteAddAccountUseCase, httpClient: HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccountUseCase(url: url, httpClient: httpClientSpy)

        return (sut, httpClientSpy)
    }
    
    class HttpClientSpy: HttpPostClientProtocol{
        var urls = [URL]()
        var inputData: Data?
        var callsCount: Int = 0
        var result: Result<Data, HttpError> = .failure(HttpError.noConnectivity)
        
        func post(to url: URL, with content: Data?) async -> Result<Data, HttpError> {
            self.urls.append(url)
            self.inputData = content
            
            return result
        }

        func setupResult(result: HttpError){
            self.result = .failure(result)
        }
        
        func setupResult(result: Data){
            self.result = .success(result)
        }
    }
}
