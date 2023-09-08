import Foundation
import Domain
import UIKit
@testable import UI

extension SignUpViewControllerTests {
    func createSUT(signUpSpy: ((AddAccountInput)-> Void)? = nil, alertViewSpy: AlertViewProtocol? = nil) -> SignUpViewController {
        let sut = SignUpViewController.instantiate()
        sut.signUp = signUpSpy
        sut.alertView = alertViewSpy

        return sut
    }

    func createAddAccountInputFromView(_ sut: SignUpViewController) -> AddAccountInput{
        AddAccountInput(
            name: sut.nameTextField?.text ?? "",
            email: sut.emailTextField?.text ?? "",
            password: sut.passwordTextField?.text ?? "",
            passwordConfirmation: sut.passwordConfirmationTextField?.text ?? "")
    }

    class AlertViewSpy: AlertViewProtocol{
        var viewModel: AlertViewModel?

        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
}
