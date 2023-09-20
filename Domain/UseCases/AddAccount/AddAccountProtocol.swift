import Foundation
import Shared

public protocol AddAccountProtocol{
    typealias AddAccountResult = Result<AddAccountOutput, DomainError>
    func handle(input: AddAccountInput) async -> AddAccountResult
}
