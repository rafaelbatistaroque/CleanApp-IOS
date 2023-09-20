import XCTest
import Presenter
import Domain
import Shared

final class LoginPresenterTests: XCTestCase {
    func test_givenLoginPresenter_whenCallsValidate_thenEnsureCallsValidateWithCorrectValues() async {
        //arrange
        let (sut, presenterValidateSpy, _) = createSut()
        let inputViewModel = fakeAuthenticationViewModel()
        let expectedData = inputViewModel.toJson()

        //act
        await sut.login(viewModel: inputViewModel)

        //assert
        expect(shouldBeTrue: NSDictionary(dictionary: presenterValidateSpy.data!).isEqual(to: expectedData!))
    }

    func test_givenLoginPresenter_whenFailsValidate_thenEnsureShowErrorMessage() async {
        //arrange
        let (sut, presenterValidateSpy, _) = createSut()
        presenterValidateSpy.simulateError()

        //act
        await sut.login(viewModel: fakeAuthenticationViewModel())

        //assert
        expect(should: sut.state, beEqual: .failure(AlertView(title: "Erro na validação", message: presenterValidateSpy.result.joined(separator: "\n")), nil))
        expect(should: sut.isShowAlert, beEqual: true)
    }

    func test_givenLoginPresenter_whenFailsValidationAuthentication_thenEnsureReturn() async {
        //arrange
        let (sut, presenterValidateSpy, authenticationSpy) = createSut()
        presenterValidateSpy.simulateError()

        //act
        await sut.login(viewModel: fakeAuthenticationViewModel())

        //assert
        expect(should: authenticationSpy.callsCount, beEqual: 0)
    }

    func test_givenLoginPresenter_whenCallsHandleUseCase_thenEnsureCallsWithCorrectValues() async {
        //arrange
        let (sut, _, authenticationSpy) = createSut()

        //act
        await sut.login(viewModel: fakeAuthenticationViewModel())

        //assert
        expect(should: authenticationSpy.input, beEqual: fakeAuthenticationInput())
    }

    func test_givenLoginPresenter_whenGenericFailsOnAuthentication_thenEnsureShowErrorMessage() async {
        //arrange
        let (sut, _, authenticationSpy) = createSut()
        authenticationSpy.resultDefined(with: .failure(.unexpected))

        //act
        await sut.login(viewModel: fakeAuthenticationViewModel())

        //assert
        if case .failure(let erro, _) = sut.state {
            expect(should: erro.title, beEqual: "Erro")
            expect(should: erro.message, beEqual: TextMessages.somethingWrongTryLater.rawValue)
            expect(should: sut.isShowAlert, beEqual: true)
        }else{noExpect()}
    }

    func test_givenLoginPresenter_whenExpiredSessionFailsOnAddAccount_thenEnsureShowErrorMessage() async {
        //arrange
        let (sut, _, authenticationSpy) = createSut()
        authenticationSpy.resultDefined(with: .failure(.expiredSession))

        //act
        await sut.login(viewModel: fakeAuthenticationViewModel())

        //assert
        if case .failure(let erro, _) = sut.state {
            expect(should: erro.title, beEqual: "Erro")
            expect(should: erro.message, beEqual: TextMessages.expiredSession.rawValue)
        }else{noExpect()}
        expect(should: sut.isShowAlert, beEqual: true)
    }

    func test_givenLoginPresenter_whenSuccessSignUp_thenEnsureShowSuccessMessage() async {
        //arrange
        let (sut, _, authenticationSpy) = createSut()
        authenticationSpy.resultDefined(with: .success(fakeAuthenticationOutput()))

        //act
        await sut.login(viewModel: fakeAuthenticationViewModel())

        //assert
        if case .success(let alert, let success) = sut.state {
            expect(should: alert.title, beEqual: "Sucesso")
            expect(should: alert.message, beEqual: TextMessages.successAuthentication.rawValue)
            expect(should: success?.accessToken, beEqual: try? authenticationSpy.result.get().accessToken)
        }else{noExpect()}
        expect(should: sut.isShowAlert, beEqual: true)
    }
}
