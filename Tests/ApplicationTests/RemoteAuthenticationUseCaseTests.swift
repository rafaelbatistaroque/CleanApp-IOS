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

}
