import Foundation
import Domain
import Shared

class AddAccountSpy: AddAccountProtocol{
    var result: Result<AddAccountOutput, DomainError> = .failure(.unexpected)
    var input: AddAccountInput?

    func handle(input: AddAccountInput) async -> Result<AddAccountOutput, DomainError> {
        self.input = input
        return self.result
    }

    func resultDefined(with result: Result<AddAccountOutput, DomainError>){
        self.result = result
    }

    func getMessageErrors() -> String? {
        if case .failure(let errors) = self.result {
            return errors.validateMessage?.joined(separator: "\n")
        }

        return nil
    }
}

extension WeakVarProxy:AddAccountProtocol where T: AddAccountProtocol{
    public func handle(input: AddAccountInput) async -> Result<AddAccountOutput, DomainError> {
        await instance?.handle(input: input) ?? .failure(.unexpected)
    }
}
