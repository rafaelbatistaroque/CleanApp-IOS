import Foundation
import Domain

final public class RemoteAddAccountUseCase{
    private let url: URL
    private let httpClient: HttpPostClientProtocol
    
    public init(url: URL, httpClient: HttpPostClientProtocol) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func handle(input: AddAccountInput){
        self.httpClient.post(to: self.url, with: input.toData())
    }
}
