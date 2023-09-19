import Foundation
import Presenter
import Domain
import Shared

extension SignUpPresenterTests {
    func createSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpPresenter, addAccount: AddAccountSpy, validate: SignUpPresenterValidateSpy){
        let addAccountSpy = AddAccountSpy()
        let signUpPresenterValidate = SignUpPresenterValidateSpy()

        @Provider var addAccountProvided = addAccountSpy as AddAccountProtocol
        @Provider var signUpPresenterValidateProvided = signUpPresenterValidate as ValidateProtocol

        let sut = SignUpPresenter()

        checkMemoryLeak(for: sut)

        return (sut, addAccountSpy, signUpPresenterValidate)
    }
}
