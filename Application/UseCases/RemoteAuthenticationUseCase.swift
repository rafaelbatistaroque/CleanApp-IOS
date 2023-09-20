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
        await httpClient.post(to: self.url, with: nil)

        return .failure(.unexpected)
    }
}

