import Foundation
import Domain
import UIKit
@testable import UI

extension SignUpViewControllerTests {
    func createSUT(signUpSpy: ((AddAccountInput)-> Void)? = nil) -> (SignUpViewController, AlertViewSpy) {
        let sut = SignUpViewController.instantiate()
        let alertViewSpy = AlertViewSpy()
        sut.signUp = signUpSpy
        sut.alertView = alertViewSpy

        return (sut, alertViewSpy)
    }

    func fillSignUpField(of sut:SignUpViewController, name:String? = nil, email:String? = nil, password:String? = nil, passwordConfirmation:String? = nil){
        sut.nameTextField?.text = name
        sut.emailTextField?.text = email
        sut.passwordTextField?.text = password
        sut.passwordConfirmationTextField?.text = passwordConfirmation
    }

    func createAddAccountInputFromView(_ sut: SignUpViewController) -> AddAccountInput{
        AddAccountInput(
            name: sut.nameTextField?.text,
            email: sut.emailTextField?.text,
            password: sut.passwordTextField?.text,
            passwordConfirmation: sut.passwordConfirmationTextField?.text)
    }

    class AlertViewSpy: AlertViewProtocol{
        var viewModel: AlertViewModel?

        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
}
