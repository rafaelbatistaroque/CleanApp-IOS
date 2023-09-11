import Foundation
import Shared
import Domain

public final class SignUpPresenter: SignUpPresenterProtocol {
    @Inject var alertView: AlertViewProtocol
    @Inject var loadingView: LoadingViewProtocol
    @Inject var addAccount: AddAccountProtocol

    public init() {
    }

    public func signUp(viewModel: AddAccountViewModel) async {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        let result = await addAccount.handle(
            input: viewModel.toAddAccountInput())

        switch result {
            case .success:
                alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: TextMessages.successAddAccount.rawValue))
            case .failure(let error):
                if let message = error.validateMessage {
                    message.isEmpty
                        ? alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: TextMessages.somethingWrongTryLater.rawValue))
                        : alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message.joined(separator: "\n")))
                }else{
                    alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: TextMessages.somethingWrongTryLater.rawValue))
                }
        }

        loadingView.display(viewModel: LoadingViewModel(isLoading: false))
    }

}
