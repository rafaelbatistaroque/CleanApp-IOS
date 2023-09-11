import Foundation
import Domain
import Shared

final public class RemoteAddAccountUseCase: AddAccountProtocol {
    private let url: URL
    @Inject var httpClient: HttpPostClientProtocol

    public required init(url: URL) {
        self.url = url
    }
    
    public func handle(input: AddAccountInput) async -> Result<AddAccountOutput, DomainError> {
        let resultAccount = Account.make(input: input)
        if case .failure(let failure) = resultAccount {
            return .failure(failure)
        }

        let account = try! resultAccount.get()
        let resultPost = await self.httpClient.post(to: self.url, with: account.toData())
        
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
