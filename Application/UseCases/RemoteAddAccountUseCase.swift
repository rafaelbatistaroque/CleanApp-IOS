import Foundation
import Domain
import Shared

public final class RemoteAddAccountUseCase: AddAccountProtocol {
    private let url: URL
    @Inject var httpClient: HttpPostClientProtocol

    public init(url: URL) {
        self.url = url
    }
    
    public func handle(input: AddAccountInput) async -> Result<AddAccountOutput, DomainError> {
        //let outputMock = AddAccountOutput(id: UUID().uuidString, name: account.name, email: account.email, password: account.password)
        let resultPost = await self.httpClient.post(to: self.url, with: input.toData())

        switch resultPost{
            case .failure(.noConnectivity):
                return .failure(.unexpected)
            case .success(let data):
                if let accountOutput: AddAccountOutput = data?.toDTO(){
                    return .success(accountOutput)
                }
                return .failure(.unexpected)
            default:
                return .failure(.unexpected)
        }
    }
}

