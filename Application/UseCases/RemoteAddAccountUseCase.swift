import Foundation
import Domain

final public class RemoteAddAccountUseCase{
    private let url: URL
    private let httpClient: HttpPostClientProtocol
    
    public init(url: URL, httpClient: HttpPostClientProtocol) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func handle(input: AddAccountInput) async -> DomainError {
        let result = await self.httpClient.post(to: self.url, with: input.toData())
        if result == .failure(.noConnectivity){
            return DomainError.unexpected
        }
        return DomainError.any
    }
}
