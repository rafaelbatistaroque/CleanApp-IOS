import Foundation
import Shared

public protocol AddAccountProtocol{
    func handle(input: AddAccountInput) async -> Result<AddAccountOutput, DomainError>
}
