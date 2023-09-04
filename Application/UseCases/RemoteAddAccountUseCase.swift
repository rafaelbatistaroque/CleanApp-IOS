import Foundation
import Domain

final public class RemoteAddAccountUseCase : AddAccountProtocol {
    private let url: URL
    private let httpClient: HttpPostClientProtocol
    
    public required init(url: URL, httpClient: HttpPostClientProtocol) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func handle(input: AddAccountInput) async -> Result<AddAccountOutput, DomainError> {
        let result = await self.httpClient.post(to: self.url, with: input.toData())

        switch result{
        case .failure(.noConnectivity):
            return .failure(DomainError.unexpected)
        default:
            return .failure(DomainError.unexpected)
        }
    }
}
