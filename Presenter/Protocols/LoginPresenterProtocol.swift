import Foundation
import Domain

protocol LoginPresenterProtocol {
    var state: StatePresenter<AuthenticationOutput, Void> {get set}
    func login(viewModel: AuthenticationViewModel) async
}
