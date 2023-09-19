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
        
        //assert
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

        //assert
        expect(
            should: httpClientSpy.data,
            beEqual: expectedContent)
    }
    
    func test_givenAddAccount_whenNoConnectivityFailsHttpPostClient_thenMustBeReturnResultUnexpectedError() async {
        //arrange
        let (sut, httpClientSpy) = createSUT()
        httpClientSpy.resultDefined(with: .failure(.noConnectivity))
        
        //act
        let result = await sut.handle(input: fakeAddAccountInputValid())
        
        //assert
        expect(
            should: result,
            beEqual: .failure(DomainError.unexpected))
    }
    
    func test_givenAddAccount_whenSuccessHttpPostClient_thenMustBeReturnResultData() async{
        //arrange
        let (sut, httpClientSpy) = createSUT()
        let expectedAccountOutput = fakeAddAccountOutput();
        httpClientSpy.resultDefined(with: .success(expectedAccountOutput.toData()!))
        
        //act
        let result = await sut.handle(input: fakeAddAccountInputValid())
        
        //assert
        expect(
            should: result,
            beEqual: .success(expectedAccountOutput)
        )
    }
    
    func test_givenAddAccount_whenInvalidDataFromHttpPostClient_thenMustBeReturnResultUnexpected() async {
        //arrange
        let (sut, httpClientSpy) = createSUT()
        httpClientSpy.resultDefined(with: .success(fakeInvalidData()))
        
        //act
        let result = await sut.handle(input: fakeAddAccountInputValid())
        
        //assert
        expect(
            should: result,
            beEqual: .failure(DomainError.unexpected))
    }

    func test_givenAddAccount_whenAnythingErrorFromHttpPostClient_thenMustBeReturnResultUnexpected() async {
        //arrange
        let (sut, httpClientSpy) = createSUT()
        httpClientSpy.resultDefined(with: .failure(.badRequest))

        //act
        let result = await sut.handle(input: fakeAddAccountInputValid())

        //assert
        expect(
            should: result,
            beEqual: .failure(DomainError.unexpected))
    }
}
