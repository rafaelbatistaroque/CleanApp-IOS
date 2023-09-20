import Foundation
import Domain

public protocol SignUpPresenterProtocol {
    var state: StatePresenter<AddAccountOutput, Void> {get set}
    var isShowAlert: Bool {get set}
    func signUp(viewModel: AddAccountViewModel) async
}
