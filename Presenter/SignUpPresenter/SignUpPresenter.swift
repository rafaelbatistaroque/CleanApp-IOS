import Foundation
import Shared
import Domain

public final class SignUpPresenter: ObservableObject, SignUpPresenterProtocol {
    @Inject public var addAccount: AddAccountProtocol
    @Inject public var validation: ValidateProtocol

    @Published public var state: StatePresenter<AddAccountOutput, Void> = .idle
    @Published public var isShowAlert: Bool = false

    public init() {}
    
    public func signUp(viewModel: AddAccountViewModel) async {
        guard await isFailValidation(of: viewModel) == false else {return}

        let result = await addAccount.handle(input: viewModel.toAddAccountInput())
        
        await MainActor.run {
            switch result {
                case .success(let success):
                    self.state = .success(AlertView(title: "Sucesso", message: TextMessages.successAddAccount.rawValue), success)
                case .failure(.emailInUse):
                    self.state = .failure(AlertView(title: "Erro", message: TextMessages.emailInUse.rawValue), nil)
                case .failure:
                    self.state = .failure(AlertView(title: "Erro", message: TextMessages.somethingWrongTryLater.rawValue), nil)
            }
            self.isShowAlert = true
        }
    }

    private func isFailValidation(of viewModel: AddAccountViewModel) async -> Bool {
        return await MainActor.run {
            self.state = .loading

            let messageErrors = self.validation.validate(data: viewModel.toJson())
            if messageErrors.isEmpty == false {
                self.state = .failure(AlertView(title: "Erro na validação", message: messageErrors.joined(separator: "\n")), nil)
                self.isShowAlert = true

                return true
            }

            return false
        }
    }
}
