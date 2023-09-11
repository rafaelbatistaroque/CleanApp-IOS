import XCTest
import Domain

final class DomainTests: XCTestCase {
    func test_givenMakeNewAccountInstance_whenNameNullOrEmpty_thenEnsureReturnFailureValidateWithSpecificMessage(){
        //arrange
        let inputWithError = fakeAddAccountInput(name: nil)

        //act
        let result = Account.make(input: inputWithError)

        //assert
        expect(should: result, beEqual: .failure(fakeAccountInputError(name: nil)))
    }

    func test_givenMakeNewAccountInstance_whenEmailNullOrEmpty_thenEnsureReturnFailureValidateWithSpecificMessage(){
        //arrange
        let inputWithError = fakeAddAccountInput(email: nil)

        //act
        let result = Account.make(input: inputWithError)

        //assert
        expect(should: result, beEqual: .failure(fakeAccountInputError(email: nil)))
    }

    func test_givenMakeNewAccountInstance_whenPasswodNullOrEmpty_thenEnsureReturnFailureValidateWithSpecificMessage(){
        //arrange
        let inputWithError = fakeAddAccountInput(password: nil)

        //act
        let result = Account.make(input: inputWithError)

        //assert
        expect(should: result, beEqual: .failure(fakeAccountInputError(password: nil)))
    }

    func test_givenMakeNewAccountInstance_whenPasswodConfirmationNullOrEmpty_thenEnsureReturnFailureValidateWithSpecificMessage(){
        //arrange
        let inputWithError = fakeAddAccountInput(passwordConfirmation: nil)

        //act
        let result = Account.make(input: inputWithError)

        //assert
        expect(should: result, beEqual: .failure(fakeAccountInputError(passwordConfirmation: nil)))
    }

    func test_givenMakeNewAccountInstance_whenPasswordAndPasswodConfirmationnotEquals_thenEnsureReturnFailureValidateWithSpecificMessage(){
        //arrange
        let inputWithError = fakeAddAccountInput(password: "any_password", passwordConfirmation: "any_password_confirmation")

        //act
        let result = Account.make(input: inputWithError)

        //assert
        expect(should: result, beEqual: .failure(fakeAccountInputError(password: "any_password", passwordConfirmation: "any_password_confirmation")))
    }

    func test_givenMakeNewAccountInstance_whenSuccess_thenEnsureReturnSuccessWithAccount() throws {
        //arrange
        let expectedAccount = fakeSuccessAccount()

        //act
        let result = Account.make(input: fakeAddAccountInput())

        //assert
        expect(should: result, beEqual: expectedAccount)
    }
}
