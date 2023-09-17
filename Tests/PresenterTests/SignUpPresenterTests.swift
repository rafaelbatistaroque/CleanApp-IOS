import XCTest
import Presenter
import Domain
import Shared

final class SignUpPresenterTests: XCTestCase {
    func test_givenSignUpPresenter_whenFailsValidationAddAccount_thenEnsureShowErrorMessage() async {
        //arrange
        let (sut, addAccountSpy) = createSut()
        addAccountSpy.resultDefined(with: .failure(fakeAccountInputError(name: nil, email: nil)))

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        expect(should: sut.state, beEqual: .failure(fakeAlertView(title: "Erro na validação", message: addAccountSpy.getMessageErrors()!)))
        expect(should: sut.isShowAlert, beEqual: true)
    }

    func test_givenSignUpPresenter_whenCallsHandleUseCase_thenEnsureCallsWithCorrectValues() async {
        //arrange
        let (sut, addAccountSpy) = createSut()

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        expect(should: addAccountSpy.input, beEqual: fakeAddAccountInput())
    }

    func test_givenSignUpPresenter_whenFailsAddAccount_thenEnsureShowErrorMessage() async {
        //arrange
        let (sut, addAccountSpy) = createSut()
        addAccountSpy.resultDefined(with: .failure(fakeAccountInputError()))

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        if case .failure(let erro) = sut.state {
            expect(should: erro.title, beEqual: "Erro")
            expect(should: erro.message, beEqual: TextMessages.somethingWrongTryLater.rawValue)
            expect(should: sut.isShowAlert, beEqual: true)
        }
    }

    func test_givenSignUpPresenter_whenFailsAddAccount_thenEnsureShowErrorMessage2() async {
        //arrange
        let (sut, addAccountSpy) = createSut()
        addAccountSpy.resultDefined(with: .failure(.unexpected))

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        if case .failure(let erro) = sut.state {
            expect(should: erro.title, beEqual: "Erro")
            expect(should: erro.message, beEqual: TextMessages.somethingWrongTryLater.rawValue)
            expect(should: sut.isShowAlert, beEqual: true)
        }
    }

    func test_givenSignUpPresenter_whenSuccessSignUp_thenEnsureShowSuccessMessage() async {
        //arrange
        let (sut, addAccountSpy) = createSut()
        addAccountSpy.resultDefined(with: .success(fakeAddAccountOutput()))

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        if case .success(let alert, let success) = sut.state {
            expect(should: alert.title, beEqual: "Sucesso")
            expect(should: alert.message, beEqual: TextMessages.successAddAccount.rawValue)
            expect(should: success.id, beEqual: try? addAccountSpy.result.get().id)
        }
        expect(should: sut.isShowAlert, beEqual: true)
    }
}
