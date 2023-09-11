import Foundation
import Presenter
import Shared

class SignUpPresenterSpy: SignUpPresenterProtocol {
    var viewModel: AddAccountViewModel?
    var emit:((AddAccountViewModel) -> Void)?

    func signUp(viewModel: AddAccountViewModel) async {
        self.emit?(viewModel)
    }

    func observer(emit: @escaping (AddAccountViewModel) -> Void){
        self.emit = emit
    }
}

extension WeakVarProxy:SignUpPresenterProtocol where T: SignUpPresenterProtocol{
    public func signUp(viewModel: Presenter.AddAccountViewModel) async {
        await instance?.signUp(viewModel: viewModel)
    }
}
