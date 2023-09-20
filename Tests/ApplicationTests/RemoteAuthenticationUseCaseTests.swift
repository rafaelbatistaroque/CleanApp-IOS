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

}
