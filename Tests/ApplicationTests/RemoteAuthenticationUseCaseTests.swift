import XCTest
import Domain
import Application

final class RemoteAuthenticationUseCaseTests: XCTestCase {

    func test_givenRemoteAuthentication_whenCallsHttpPostClient_thenMustBePassingCorrectUrl() async {
        //arrange
        let expectedRemoteUrl = fakeURL()
        let (sut, httpClientSpy) = createSUT(url: expectedRemoteUrl)

        //act
        let _ = await sut.handle(input: fakeAuthenticationInputValid())

        //assert
        expect(
            should: [expectedRemoteUrl],
            beEqual: httpClientSpy.urls)
    }

    func test_givenRemoteAuthentication_whenCallsHttpPostClient_thenMustBePassingCorrectData() async{
        //arrange
        let (sut, httpClientSpy) = createSUT()
        let input = fakeAuthenticationInputValid()
        let expectedContent = input.toData();

        //act
        let _ = await sut.handle(input: input)

        //assert
        expect(
            should: httpClientSpy.data,
            beEqual: expectedContent)
    }

    func test_givenRemoteAuthentication_whenNoConnectivityFailsHttpPostClient_thenMustBeReturnResultUnexpectedError() async {
        //arrange
        let (sut, httpClientSpy) = createSUT()
        httpClientSpy.resultDefined(with: .failure(.noConnectivity))

        //act
        let result = await sut.handle(input: fakeAuthenticationInputValid())

        //assert
        expect(
            should: result,
            beEqual: .failure(.unexpected))
    }

    func test_givenRemoteAuthentication_whenUnauthorizedFailsHttpPostClient_thenMustBeReturnResultSessionExpired() async {
        //arrange
        let (sut, httpClientSpy) = createSUT()
        httpClientSpy.resultDefined(with: .failure(.unauthorized))

        //act
        let result = await sut.handle(input: fakeAuthenticationInputValid())

        //assert
        expect(
            should: result,
            beEqual: .failure(DomainError.expiredSession))
    }

    func test_givenRemoteAuthentication_whenSuccessHttpPostClient_thenMustBeReturnResultData() async{
        //arrange
        let (sut, httpClientSpy) = createSUT()
        let expectedAccountOutput = fakeAuthenticationOutput();
        httpClientSpy.resultDefined(with: .success(expectedAccountOutput.toData()!))

        //act
        let result = await sut.handle(input: fakeAuthenticationInputValid())

        //assert
        expect(
            should: result,
            beEqual: .success(expectedAccountOutput)
        )
    }

    func test_givenRemoteAuthentication_whenInvalidDataFromHttpPostClient_thenMustBeReturnResultUnexpected() async {
        //arrange
        let (sut, httpClientSpy) = createSUT()
        httpClientSpy.resultDefined(with: .success(fakeInvalidData()))

        //act
        let result = await sut.handle(input: fakeAuthenticationInputValid())

        //assert
        expect(
            should: result,
            beEqual: .failure(.unexpected))
    }

}
