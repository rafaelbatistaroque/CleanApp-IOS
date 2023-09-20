import Foundation
import Shared

public protocol AuthenticationProtocol{
    typealias AuthenticationResult = Result<AuthenticationOutput, DomainError>
    func handle(input: AuthenticationInput) async -> AuthenticationResult
}
