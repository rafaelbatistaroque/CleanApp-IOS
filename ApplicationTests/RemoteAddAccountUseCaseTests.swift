import XCTest
import Domain
import Application

final class RemoteAddAccountUseCaseTests: XCTestCase {
    func test_givenAddAccount_whenCallsHttpPostClient_thenMustBePassingCorrectUrl() async {
        //arrange
        let expectedRemoteUrl = fakeURL()
        let (sut, httpClientSpy) = createSUT(url: expectedRemoteUrl)
        
        //act
        let _ = await sut.handle(input: fakeAddAccountInputValid())
        
        //asset
        expect(
            should: [expectedRemoteUrl],
            beEqual: httpClientSpy.urls)
    }
    
    func test_givenAddAccount_whenCallsHttpPostClient_thenMustBePassingCorrectData() async{
        //arrange
        let (sut, httpClientSpy) = createSUT()
        let input = fakeAddAccountInputValid()
        let expectedContent = input.toData();
        
        //act
        let _ = await sut.handle(input: input)
        
        //asset
        expect(
            should: httpClientSpy.inputData,
            beEqual: expectedContent)
    }
    
    func test_givenAddAccount_whenNoConnectivityFailsHttpPostClient_thenMustBeReturnResultUnexpectedError() async {
        //arrange
        let (sut, httpClientSpy) = createSUT()
        httpClientSpy.result(with: .failure(.noConnectivity))
        
        //act
        let result = await sut.handle(input: fakeAddAccountInputValid())
        
        //asset
        expect(
            should: result,
            beEqual: .failure(DomainError.unexpected))
    }
    
    func test_givenAddAccount_whenSuccessHttpPostClient_thenMustBeReturnResultData() async{
        //arrange
        let (sut, httpClientSpy) = createSUT()
        let expectedAccountOutput = fakeAddAccountOutput();
        httpClientSpy.result(with: .success(expectedAccountOutput.toData()!))
        
        //act
        let result = await sut.handle(input: fakeAddAccountInputValid())
        
        //asset
        expect(
            should: result,
            beEqual: .success(expectedAccountOutput)
        )
    }
    
    func test_givenAddAccount_whenInvalidDataFromHttpPostClient_thenMustBeReturnResultUnexpected() async {
        //arrange
        let (sut, httpClientSpy) = createSUT()
        httpClientSpy.result(with: .success(fakeInvalidData()))
        
        //act
        let result = await sut.handle(input: fakeAddAccountInputValid())
        
        //asset
        expect(
            should: result,
            beEqual: .failure(DomainError.unexpected))
    }
}

extension RemoteAddAccountUseCaseTests {
    func fakeAddAccountInputValid() -> AddAccountInput{
        AddAccountInput(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_password")
    }
    
    func fakeAddAccountOutput() -> AddAccountOutput{
        AddAccountOutput(id: "any_id", name: "any_name", email: "any_email", password: "any_password")
    }
    
    func fakeInvalidData() -> Data{
        Data("invalid_data".utf8)
    }
    
    func fakeURL() -> URL{
        URL(string: "https://any_url.com")!
    }
    
    func createSUT(url: URL = URL(string: "https://any_url.com")!) -> (sut: RemoteAddAccountUseCase, httpClient: HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccountUseCase(url: url, httpClient: httpClientSpy)
        
        return (sut, httpClientSpy)
    }
    
    class HttpClientSpy: HttpPostClientProtocol{
        var urls = [URL]()
        var inputData: Data?
        var result: Result<Data, HttpError> = .failure(HttpError.noConnectivity)
        
        func post(to url: URL, with data: Data?) async -> Result<Data, HttpError> {
            self.urls.append(url)
            self.inputData = data
            
            return result
        }
        
        func result(with result: Result<Data, HttpError>){
            self.result = result
        }
    }
}
