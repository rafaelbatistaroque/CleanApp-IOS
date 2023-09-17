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
        let resultAccount = Account.make(input: input)
        if case .failure(let failure) = resultAccount {
            return .failure(failure)
        }

        let account = try! resultAccount.get()
        //mock made due api has benn down | original: account.toData()
//        let outputMock = AddAccountOutput(id: UUID().uuidString, name: account.name, email: account.email, password: account.password)
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
