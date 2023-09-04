import Foundation

public protocol AddAccountProtocol{
    func handle(input: AddAccountInput) async -> Result<AddAccountOutput, DomainError>
}
