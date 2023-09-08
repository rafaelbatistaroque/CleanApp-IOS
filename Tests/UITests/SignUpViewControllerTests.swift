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

    func test_givenSignUpPage_whenOnTapSaveButton_thenEnsureDisableUserInterface(){
        //arrange
        let sut = createSUT(signUpSpy: nil)
        sut.loadViewIfNeeded()

        //act
        sut.saveButton?.simulateTap()

        //assert
        expect(should: sut.view?.isUserInteractionEnabled, beEqual: false)
    }

}
