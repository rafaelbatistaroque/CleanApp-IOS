import XCTest
import Presenter
import Domain
import Shared

final class SignUpPresenterTests: XCTestCase {
    func test_givenSignUpPresenter_whenFailsValidationAddAccount_thenEnsureShowErrorMessage() async {
        //arrange
        let (sut, alertViewSpy, addAccountSpy,_) = createSut()
        addAccountSpy.resultDefined(with: .failure(fakeAccountInputError(name: nil, email: nil)))

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        expect(should: alertViewSpy.viewModel?.message, beEqual: addAccountSpy.getMessageErrors())
    }

    func test_givenSignUpPresenter_whenCallsHandleUseCase_thenEnsureCalssWithCorrectValues() async {
        //arrange
        let (sut, _, addAccountSpy,_) = createSut()

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        expect(should: addAccountSpy.input, beEqual: fakeAddAccountInput())
    }

    func test_givenSignUpPresenter_whenFailsAddAccount_thenEnsureShowErrorMessage() async {
        //arrange
        let (sut, alertViewSpy, addAccountSpy,_) = createSut()
        addAccountSpy.resultDefined(with: .failure(.unexpected))

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        expect(should: alertViewSpy.viewModel?.title, beEqual: "Erro")
        expect(should: alertViewSpy.viewModel?.message, beEqual: TextMessages.somethingWrongTryLater.rawValue)
    }

    func test_givenSignUpPresenter_whenSignUp_thenEnsureShowLoadingBeforeAddAccount() async {
        //arrange
        let (sut, _, _, loadingViewSpy) = createSut()
        loadingViewSpy.inicialLoading()

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        expect(should: loadingViewSpy.isLoading, beEqual: true)
        expect(should: loadingViewSpy.isInicialLoading, beEqual: true)
        expect(should: loadingViewSpy.isEndLoading, beEqual: false)
    }

    func test_givenSignUpPresenter_whenSignUp_thenEnsureHideLoadingAfterAddAccount() async {
        //arrange
        let (sut, _, _, loadingViewSpy) = createSut()
        loadingViewSpy.endLoading()

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        expect(should: loadingViewSpy.isLoading, beEqual: false)
        expect(should: loadingViewSpy.isEndLoading, beEqual: true)
        expect(should: loadingViewSpy.isInicialLoading, beEqual: false)
    }

    func test_givenSignUpPresenter_whenSuccessSignUp_thenEnsureShowSuccessMessage() async {
        //arrange
        let (sut, alertViewSpy, addAccountSpy,_) = createSut()
        addAccountSpy.resultDefined(with: .success(fakeAddAccountOutput()))

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        expect(should: alertViewSpy.viewModel?.title, beEqual: "Sucesso")
        expect(should: alertViewSpy.viewModel?.message, beEqual: TextMessages.successAddAccount.rawValue)
    }
}
