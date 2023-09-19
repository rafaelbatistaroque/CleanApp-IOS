import XCTest
import Presenter
import Domain
import Shared

final class SignUpPresenterTests: XCTestCase {
    func test_givenSignUpPresenter_whenCallsValidate_thenEnsureCallsValidateWithCorrectValues() async {
        //arrange
        let (sut, _, validationSpy) = createSut()
        let inputViewModel = fakeAddAccountViewModel()
        let expectedData = inputViewModel.toJson()

        //act
        await sut.signUp(viewModel: inputViewModel)

        //assert
        expect(shouldBeTrue: NSDictionary(dictionary: validationSpy.data!).isEqual(to: expectedData!))
    }

    func test_givenSignUpPresenter_whenFailsValidate_thenEnsureShowErrorMessage() async {
        //arrange
        let (sut, _, validationSpy) = createSut()
        validationSpy.simulateError()

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        expect(should: sut.state, beEqual: .failure(AlertView(title: "Erro na validação", message: validationSpy.result.joined(separator: "\n"))))
        expect(should: sut.isShowAlert, beEqual: true)
    }

    func test_givenSignUpPresenter_whenFailsValidationAddAccount_thenEnsureReturn() async {
        //arrange
        let (sut, addAccountSpy, validationSpy) = createSut()
        validationSpy.simulateError()

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        expect(should: addAccountSpy.callsCount, beEqual: 0)
    }

    func test_givenSignUpPresenter_whenCallsHandleUseCase_thenEnsureCallsWithCorrectValues() async {
        //arrange
        let (sut, addAccountSpy, _) = createSut()

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        expect(should: addAccountSpy.input, beEqual: fakeAddAccountInput())
    }

    func test_givenSignUpPresenter_whenFailsAddAccount_thenEnsureShowErrorMessage() async {
        //arrange
        let (sut, addAccountSpy, _) = createSut()
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
        let (sut, addAccountSpy, _) = createSut()
        addAccountSpy.resultDefined(with: .success(fakeAddAccountOutput()))

        //act
        await sut.signUp(viewModel: fakeAddAccountViewModel())

        //assert
        if case .success(let alert, let success) = sut.state {
            expect(should: alert.title, beEqual: "Sucesso")
            expect(should: alert.message, beEqual: TextMessages.successAddAccount.rawValue)
            expect(should: success.accessToken, beEqual: try? addAccountSpy.result.get().accessToken)
        }
        expect(should: sut.isShowAlert, beEqual: true)
    }

    func test_givenAddAccountViewModel_whenNotSameInstance_thenEnsureReturnFalse(){
        //arrange & act
        let instance1 = fakeAddAccountViewModel()
        let instance2 = fakeAddAccountViewModel()

        //assert
        expect(should: instance1, notBeEqual: instance2)
    }

    func test_givenAddAccountViewModel_whenSameInstance_thenEnsureReturnTrue(){
        //arrange & act
        let instance1 = fakeAddAccountViewModel()
        let sameInstance = instance1

        //assert
        expect(should: instance1, beEqual: sameInstance)
    }

    func test_givenAddAccountViewModel_whentoAddAccountInput_thenEnsureReturnAddAccountInputWithCorrectData(){
        //arrange
        let addAccountViewModel = fakeAddAccountViewModel()

        //act
        let result = addAccountViewModel.toAddAccountInput()

        //assert
        expect(should: result.name, beEqual: addAccountViewModel.name)
        expect(should: result.email, beEqual: addAccountViewModel.email)
        expect(should: result.password, beEqual: addAccountViewModel.password)
        expect(should: result.passwordConfirmation, beEqual: addAccountViewModel.passwordConfirmation)
    }
}
