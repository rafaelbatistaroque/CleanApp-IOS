import XCTest
import Domain
import Presenter
import Shared
import UIKit
@testable import UI

final class SignUpViewControllerTests: XCTestCase {
    func test_givenSignUpPage_whenStart_thenEnsureLoadingIsHidden(){
        //arrange
        let (sut, _) = createSUT()

        //act
        sut.loadViewIfNeeded()

        //assert
        expect(should: sut.loadingIndicator?.isAnimating, beEqual: false)
    }

    func test_givenSignUpPage_whenInstanced_thenEnsureExtendsLoadingViewProtocol(){
        //arrange
        let (sut, _) = createSUT()

        //act & assert
        expect(shouldNotBeNil: sut as LoadingViewProtocol)
    }

    func test_givenSignUpPage_whenInstanced_thenEnsureExtendsAlertViewProtocol(){
        //arrange
        let (sut, _) = createSUT()

        //act & assert
        expect(shouldNotBeNil: sut as AlertViewProtocol)
    }

    func test_givenSignUpPresenter_whenOnTapSaveButton_thenEnsureCallsSignUpWithCorrectAddAccountInput() {
        //arrange
        let (sut, signUpPresenterSpy) = createSUT()
        sut.loadViewIfNeeded()

        //act
        sut.saveButton.simulateTap()

        //assert
        signUpPresenterSpy.observer { [weak self] viewModel in
            self?.expect(should: viewModel, beEqual: self?.createAddAccountInputFromView(sut))
        }
    }
}
