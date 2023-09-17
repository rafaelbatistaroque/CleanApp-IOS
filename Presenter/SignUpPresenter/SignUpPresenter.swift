import Foundation
import Shared
import Domain

public final class SignUpPresenter: ObservableObject, SignUpPresenterProtocol {
    @Inject private var addAccount: AddAccountProtocol
    
    @Published public var state: StatePresenter = .idle
    @Published public var isShowAlert: Bool = false
    
    public init() {}
    
    public func signUp(viewModel: AddAccountViewModel) async {
        await MainActor.run {
            self.state = .loading
        }
        
        let result = await addAccount.handle(input: viewModel.toAddAccountInput())
        
        await MainActor.run {
            switch result {
                case .success(let success):
                    self.state = .success(AlertView(title: "Sucesso", message: TextMessages.successAddAccount.rawValue), success)
                case .failure(let error):
                    if let message = error.validateMessage {
                        if message.isEmpty == false {
                            self.state = .failure(AlertView(title: "Erro na validação", message: error.validateMessage!.joined(separator: "\n")))
                            self.isShowAlert = true
                            return
                        }

                    }
                    self.state = .failure(AlertView(title: "Erro", message: TextMessages.somethingWrongTryLater.rawValue))
            }
            self.isShowAlert = true
        }
    }
}
