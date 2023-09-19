import Foundation
import Shared
import Domain

public final class SignUpPresenter: ObservableObject, SignUpPresenterProtocol {
    @Inject public var addAccount: AddAccountProtocol
    @Inject public var validation: any ValidateProtocol

    @Published public var state: StatePresenter = .idle
    @Published public var isShowAlert: Bool = false

    public init() {}
    
    public func signUp(viewModel: AddAccountViewModel) async {
        let isFailValidation = await MainActor.run { () -> Bool in
            self.state = .loading
            
            let messageErrors = validation.validate(data: viewModel.toJson())
            if messageErrors.isEmpty == false {
                self.state = .failure(AlertView(title: "Erro na validação", message: messageErrors.joined(separator: "\n")))
                self.isShowAlert = true

                return true
            }

            return false
        }

        if isFailValidation {return}

        let result = await addAccount.handle(input: viewModel.toAddAccountInput())
        
        await MainActor.run {
            switch result {
                case .success(let success):
                    self.state = .success(AlertView(title: "Sucesso", message: TextMessages.successAddAccount.rawValue), success)
                case .failure(let error):
                    self.state = error == .emailInUse
                        ? .failure(AlertView(title: "Erro", message: TextMessages.emailInUse.rawValue))
                        : .failure(AlertView(title: "Erro", message: TextMessages.somethingWrongTryLater.rawValue))
            }
            self.isShowAlert = true
        }
    }
}
