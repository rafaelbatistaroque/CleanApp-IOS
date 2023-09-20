import Foundation
import Presenter
import Domain
import Shared

extension SignUpPresenterTests {
    func createSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpPresenter, addAccount: AddAccountSpy, validate: PresenterValidateSpy){
        let addAccountSpy = AddAccountSpy()
        let presenterValidate = PresenterValidateSpy()

        @Provider var addAccountProvided = addAccountSpy as AddAccountProtocol
        @Provider var presenterValidateProvided = presenterValidate as ValidateProtocol

        let sut = SignUpPresenter()

        checkMemoryLeak(for: sut)

        return (sut, addAccountSpy, presenterValidate)
    }
}
