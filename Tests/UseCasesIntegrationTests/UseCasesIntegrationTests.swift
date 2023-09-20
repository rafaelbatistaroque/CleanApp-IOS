import XCTest
import Domain

final class UseCasesIntegrationTests: XCTestCase {
    func test_a_givenAddAccount_whenSuccessSignup_thenReturnAccountCreated() async {
        //arrange
        let sut = createSUT()
        let addAccountInput = AddAccountInput(name: "Rafael Batista", email: "\(UUID().uuidString)@gmail.com", password: "fordev.67", passwordConfirmation: "fordev.67")

        //act
        let result = await sut.handle(input: addAccountInput)

        switch result {
            case .failure:
                XCTFail("Expected success got \(result) instead")
            case .success(let accountOutput):
                //assert
                expect(shouldNotBeNil: accountOutput.accessToken)
        }
    }

    func test_b_givenAddAccount_whenFailSignup_thenReturnUnexpectedError() async {
        //arrange
        let sut = createSUT()
        let addAccountInput = AddAccountInput(name: "Rafael Batista", email: "5D14BBD1-93D8-4349-B7F9-24270B8B616D@gmail.com", password: "fordev.68", passwordConfirmation: "fordev.67")

        //act
        let result = await sut.handle(input: addAccountInput)

        switch result {
            case .failure(let error) where error == .emailInUse:
                expect(shouldNotBeNil: error)
            case .failure(let error):
                //assert
                expect(should: error, beEqual: .unexpected)
            case .success:
                XCTFail("Expected success got \(result) instead")
        }
    }
}
