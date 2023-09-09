import XCTest
import Domain
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

    func test_givenSignUpPage_whenOnTapSaveButton_thenEnsureCallsSignUpWithCorrectAddAccountInput(){
        //arrange
        var addAccountInput: AddAccountInput?
        let (sut, _) = createSUT(signUpSpy: { addAccountInput = $0 })
        sut.loadViewIfNeeded()

        //act
        sut.saveButton?.simulateTap()

        //assert
        expect(should: addAccountInput, beEqual: createAddAccountInputFromView(sut))
    }

    func test_givenSignUpPageWithKeyBoardingShown_whenOnTapSaveButton_thenEnsureDisableUserInterface(){
        //arrange
        let (sut, _)  = createSUT()
        sut.loadViewIfNeeded()

        //act
        sut.saveButton?.simulateTap()

        //assert
        expect(should: sut.view?.isUserInteractionEnabled, beEqual: false)
    }

    func test_givenSignUpPageAfterOnTapSaveButton_whenNameNotProvided_thenEnsureShowErrorMessage(){
        //arrange
        let expectedAlertViewModel =  AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório")
        let (sut, alertViewSpy) = createSUT()
        sut.loadViewIfNeeded()
        fillSignUpField(of: sut, name: nil)

        //act
        sut.saveButton?.simulateTap()

        //assert
        expect(should: alertViewSpy.viewModel, beEqual: expectedAlertViewModel)
    }

    func test_givenSignUpPageAfterOnTapSaveButton_whenEmailNotProvided_thenEnsureShowErrorMessage(){
        //arrange
        let expectedAlertViewModel =  AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatório")
        let (sut, alertViewSpy) = createSUT()
        sut.loadViewIfNeeded()
        fillSignUpField(of: sut, name: "any_name", email: nil)

        //act
        sut.saveButton?.simulateTap()

        //assert
        expect(should: alertViewSpy.viewModel, beEqual: expectedAlertViewModel)
    }

    func test_givenSignUpPageAfterOnTapSaveButton_whenPasswordNotProvided_thenEnsureShowErrorMessage(){
        //arrange
        let expectedAlertViewModel =  AlertViewModel(title: "Falha na validação", message: "O campo Senha é obrigatório")
        let (sut, alertViewSpy) = createSUT()
        sut.loadViewIfNeeded()
        fillSignUpField(of: sut, name: "any_name", email: "any_email", password: nil)

        //act
        sut.saveButton?.simulateTap()

        //assert
        expect(should: alertViewSpy.viewModel, beEqual: expectedAlertViewModel)
    }

    func test_givenSignUpPageAfterOnTapSaveButton_whenPasswordConfirmationNotProvided_thenEnsureShowErrorMessage(){
        //arrange
        let expectedAlertViewModel =  AlertViewModel(title: "Falha na validação", message: "O campo Confirmar de Senha é obrigatório")
        let (sut, alertViewSpy) = createSUT()
        sut.loadViewIfNeeded()
        fillSignUpField(of: sut, name: "any_name", email: "any_email", password: "enay_password", passwordConfirmation: nil)

        //act
        sut.saveButton?.simulateTap()

        //assert
        expect(should: alertViewSpy.viewModel, beEqual: expectedAlertViewModel)
    }

    func test_givenSignUpPageAfterOnTapSaveButton_whenPasswordAndPasswordConfirmationNotMatch_thenEnsureShowErrorMessage(){
        //arrange
        let expectedAlertViewModel =  AlertViewModel(title: "Falha na validação", message: "Os campos Senha e Confirmar Senha não são iguais")
        let (sut, alertViewSpy) = createSUT()
        sut.loadViewIfNeeded()
        fillSignUpField(of: sut, name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "another_any_password")

        //act
        sut.saveButton?.simulateTap()

        //assert
        expect(should: alertViewSpy.viewModel, beEqual: expectedAlertViewModel)
    }


}
