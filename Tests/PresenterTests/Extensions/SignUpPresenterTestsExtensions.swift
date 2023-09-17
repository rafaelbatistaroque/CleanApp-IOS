import Foundation
import Presenter
import Domain
import Shared

extension SignUpPresenterTests {
    func createSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpPresenter, addAccount: AddAccountSpy){
        let addAccountSpy = AddAccountSpy()

        @Provider var AddAccountProvided = addAccountSpy as AddAccountProtocol

        let sut = SignUpPresenter()

        checkMemoryLeak(for: sut)

        return (sut, addAccountSpy)
    }
}
