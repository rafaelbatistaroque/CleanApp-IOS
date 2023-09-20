import Foundation
import Domain
import Shared

public final class RemoteAuthenticationUseCase: AuthenticationProtocol {
    private let url: URL

    @Inject var httpClient: HttpPostClientProtocol

    public init(url: URL) {
        self.url = url
    }

    public func handle(input: AuthenticationInput) async -> AuthenticationResult {
        let resultPost = await httpClient.post(to: self.url, with: input.toData())

        switch resultPost {
            case .failure(.noConnectivity):
                return .failure(.unexpected)
            case .failure(.unauthorized):
                return .failure(.expiredSession)
            case .success(let data):
                if let authenticationOutput: AuthenticationOutput = data?.toDTO(){
                    return .success(authenticationOutput)
                }
                return .failure(.unexpected)
            default:
                return .failure(.emailInUse)
        }
    }
}

