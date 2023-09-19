import Foundation
import Domain
import Shared

class AddAccountSpy: AddAccountProtocol{
    var result: Result<AddAccountOutput, DomainError> = .failure(.unexpected)
    var input: AddAccountInput?
    var callsCount: Int = 0

    func handle(input: AddAccountInput) async -> Result<AddAccountOutput, DomainError> {
        self.callsCount += 1
        self.input = input
        return self.result
    }

    func resultDefined(with result: Result<AddAccountOutput, DomainError>){
        self.result = result
    }
}
