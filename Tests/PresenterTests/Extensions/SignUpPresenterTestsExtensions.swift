import Foundation
import Presenter
import Domain
import Shared

extension SignUpPresenterTests {
    func createSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpPresenter, alertView: AlertViewSpy, addAccount: AddAccountSpy, loadingView: LoadingViewSpy){
        let alertViewSpy = AlertViewSpy()
        let loadingViewSpy = LoadingViewSpy()
        let addAccountSpy = AddAccountSpy()

        @Provider var alertViewProvided = WeakVarProxy(alertViewSpy) as AlertViewProtocol
        @Provider var loadingViewProvided = WeakVarProxy(loadingViewSpy) as LoadingViewProtocol
        @Provider var AddAccountProvided = WeakVarProxy(addAccountSpy) as AddAccountProtocol

        let sut = SignUpPresenter()

        checkMemoryLeak(for: alertViewSpy, file: file, line: line)
        checkMemoryLeak(for: loadingViewSpy, file: file, line: line)
        checkMemoryLeak(for: addAccountSpy, file: file, line: line)
        checkMemoryLeak(for: sut)

        return (sut, alertViewSpy, addAccountSpy, loadingViewSpy)
    }
}
