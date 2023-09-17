import XCTest
import Domain
import Application

final class RemoteAddAccountUseCaseTests: XCTestCase {
    func test_givenAddAccount_whenFailMakeAccount_thenMustReturnFailureWithMessage() async {
        //arrange
        let (sut, _) = createSUT()

        //act
        let result = await sut.handle(input: fakeAddAccountInputInvalidWith(name: nil))

        //assert
        if case .failure(let failure) = result {
            expect(
                should: failure,
                beEqual: .validate(withMessage: failure.validateMessage!))
        }else{noExpect(item: result)}
    }

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
        let account = try! fakeSuccessAccount().get()
        let expectedContent = account.toData();

        //act
        let _ = await sut.handle(input: fakeAddAccountInputValid())

        //assert
        expect(
            should: httpClientSpy.inputData,
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
