import Foundation
import Presenter
import Domain
import Shared

extension LoginPresenterTests {
    func createSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: LoginPresenter, validate: PresenterValidateSpy, authenticationSpy: AuthenticationSpy){
        let authenticationSpy = AuthenticationSpy()
        let presenterValidate = PresenterValidateSpy()

        @Provider var authenticationSpyProvided = authenticationSpy as AuthenticationProtocol
        @Provider var presenterValidateProvided = presenterValidate as ValidateProtocol

        let sut = LoginPresenter()

        checkMemoryLeak(for: sut)

        return (sut, presenterValidate, authenticationSpy)
    }
}
