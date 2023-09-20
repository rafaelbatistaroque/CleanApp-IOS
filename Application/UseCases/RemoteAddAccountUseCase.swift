import Foundation
import Domain
import Shared

public final class RemoteAddAccountUseCase: AddAccountProtocol {
    private let url: URL
    @Inject var httpClient: HttpPostClientProtocol

    public init(url: URL) {
        self.url = url
    }
    
    public func handle(input: AddAccountInput) async -> AddAccountResult {
        let resultPost = await self.httpClient.post(to: self.url, with: input.toData())

        switch resultPost {
            case .failure(.noConnectivity):
                return .failure(.unexpected)
            case .failure(let error):
                return error == .forbidden
                    ? .failure(.emailInUse)
                    : .failure(.unexpected)
            case .success(let data):
                if let accountOutput: AddAccountOutput = data?.toDTO(){
                    return .success(accountOutput)
                }
                return .failure(.unexpected)
        }
    }
}

