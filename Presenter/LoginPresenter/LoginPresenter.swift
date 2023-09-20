import Foundation
import Shared
import Domain

public final class LoginPresenter: LoginPresenterProtocol{
    @Inject public var authentication: AuthenticationProtocol
    @Inject public var validation: any ValidateProtocol

    @Published public var state: StatePresenter<AuthenticationOutput, Void> = .idle
    @Published public var isShowAlert: Bool = false

    public init(){}

    public func login(viewModel: AuthenticationViewModel) async {
        guard await isFailValidation(of: viewModel) == false else {return}

        let result = await authentication.handle(input: viewModel.toAuthenticationInput())

        await MainActor.run {
            switch result {
                case .failure(.expiredSession):
                    self.state = .failure(AlertView(title: "Erro", message: TextMessages.expiredSession.rawValue), nil)
                case .failure:
                    self.state = .failure(AlertView(title: "Erro", message: TextMessages.somethingWrongTryLater.rawValue), nil)
                case .success(let success):
                    self.state = .success(AlertView(title: "Sucesso", message: TextMessages.successAuthentication.rawValue), success)
            }
            self.isShowAlert = true
        }
    }

    private func isFailValidation(of viewModel: AuthenticationViewModel) async -> Bool {
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
