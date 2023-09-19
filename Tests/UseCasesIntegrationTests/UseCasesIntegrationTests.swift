import XCTest
import Application
import Infra
import Domain
import Shared
import Alamofire

final class UseCasesIntegrationTests: XCTestCase {
    func test_givenAddAccount_whenSuccessSignup_thenReturnAccountCreated() async {
        //arrange
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        @Provider var alamofireProvided = Session()
        @Provider var adapterProvided = AlamofireAdapter() as HttpPostClientProtocol
        let sut = RemoteAddAccountUseCase(url: url)
        let addAccountInput = AddAccountInput(name: "Rafael Batista", email: "rafael.batista.pessoal@gmail.com", password: "fordev.67", passwordConfirmation: "fordev.67")

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

    func test_givenAddAccount_whenFailSignup_thenReturnAccountCreated() async {
        //arrange
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        @Provider var alamofireProvided = Session()
        @Provider var adapterProvided = AlamofireAdapter() as HttpPostClientProtocol
        let sut = RemoteAddAccountUseCase(url: url)
        let addAccountInput = AddAccountInput(name: "Rafael Batista", email: "rafael.batista.pessoal@gmail.com", password: "fordev.68", passwordConfirmation: "fordev.67")

        //act
        let result = await sut.handle(input: addAccountInput)

        switch result {
            case .failure(let error):
                //assert
                expect(should: error, beEqual: .unexpected)
            case .success:
                XCTFail("Expected success got \(result) instead")
        }
    }
}
