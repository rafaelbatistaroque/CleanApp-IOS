import Foundation
import Presenter
import Shared
import Application
import Domain

class SignUpPresenterFactory{
    static func factory() -> SignUpPresenter {
        @Provider var addAccountProvided = RemoteAddAccountUseCaseFactory.factory() as AddAccountProtocol
        @Provider var addAccountViewModelProvided = AddAccountViewModel()
        return SignUpPresenter()
    }

    deinit{
        print("deinit SignUpPresenterFactory")
    }
}
