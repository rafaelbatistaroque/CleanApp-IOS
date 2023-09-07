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

    func test_givenSignUpPage_whenOnTapSaveButton_thenEnsureCallsSignUp(){
        //arrange
        var callsCount = 0
        let sut = createSUT(signUpSpy: { _ in
            callsCount += 1
        })
        sut.loadViewIfNeeded()

        //act
        sut.saveButton?.simulateTap()

        //assert
        expect(should: callsCount, beEqual: 1)
    }

}

extension SignUpViewControllerTests {
    func createSUT(signUpSpy: ((AddAccountInput)-> Void)? = nil) -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        sut.signUp = signUpSpy

        return sut
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
