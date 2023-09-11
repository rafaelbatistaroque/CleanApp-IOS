import Foundation
import Domain
import Presenter
import Shared
import UIKit
@testable import UI

extension SignUpViewControllerTests {
    func createSUT(file: StaticString = #filePath, line: UInt = #line) -> (SignUpViewController, SignUpPresenterSpy) {
        let signUpPresenterSpy = SignUpPresenterSpy()
        @Provider var signUpPresenterProvided = WeakVarProxy(signUpPresenterSpy) as SignUpPresenterProtocol

        let sut = SignUpViewController.instantiate()

        checkMemoryLeak(for: signUpPresenterSpy, file: file, line: line)

        return (sut, signUpPresenterSpy)
    }

    func createAddAccountInputFromView(_ sut: SignUpViewController) -> AddAccountViewModel{
        AddAccountViewModel(
            name: sut.nameTextField.text,
            email: sut.emailTextField.text,
            password: sut.passwordTextField.text,
            passwordConfirmation: sut.passwordConfirmationTextField?.text)
    }
}
