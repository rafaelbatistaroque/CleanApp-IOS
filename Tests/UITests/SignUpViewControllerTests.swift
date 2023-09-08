import XCTest
import Domain
import UIKit
@testable import UI

final class SignUpViewControllerTests: XCTestCase {
    func test_givenSignUpPage_whenStart_thenEnsureLoadingIsHidden(){
        //arrange
        let sut = createSUT()

        //act
        sut.loadViewIfNeeded()

        //assert
        expect(should: sut.loadingIndicator?.isAnimating, beEqual: false)
    }

    func test_givenSignUpPage_whenInstanced_thenEnsureExtendsLoadingViewProtocol(){
        //arrange
        let sut = createSUT()

        //act & assert
        expect(shouldNotBeNil: sut as LoadingViewProtocol)
    }

    func test_givenSignUpPage_whenInstanced_thenEnsureExtendsAlertViewProtocol(){
        //arrange
        let sut = createSUT()

        //act & assert
        expect(shouldNotBeNil: sut as AlertViewProtocol)
    }

    func test_givenSignUpPage_whenOnTapSaveButton_thenEnsureCallsSignUpWithCorrectAddAccountInput(){
        //arrange
        var addAccountInput: AddAccountInput?
        let sut = createSUT(signUpSpy: { addAccountInput = $0 })
        sut.loadViewIfNeeded()

        //act
        sut.saveButton?.simulateTap()

        //assert
        expect(should: addAccountInput, beEqual: createAddAccountInputFromView(sut))
    }

}

extension SignUpViewControllerTests {
    func createSUT(signUpSpy: ((AddAccountInput)-> Void)? = nil) -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.signUp = signUpSpy

        return sut
    }

    func createAddAccountInputFromView(_ sut: SignUpViewController) -> AddAccountInput{
        AddAccountInput(
            name: sut.nameTextField?.text ?? "",
            email: sut.emailTextField?.text ?? "",
            password: sut.passwordTextField?.text ?? "",
            passwordConfirmation: sut.passwordConfirmationTextField?.text ?? "")
    }
}

extension UIControl {
    func simulate(event: UIControl.Event){
        self.allTargets.forEach { target in
            self.actions(forTarget: target, forControlEvent: event)?.forEach { action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }

    func simulateTap(){
        simulate(event: .touchUpInside)
    }
}
