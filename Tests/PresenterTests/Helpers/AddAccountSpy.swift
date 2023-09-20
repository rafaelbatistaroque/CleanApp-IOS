import Foundation
import Domain
import Shared

class AddAccountSpy: AddAccountProtocol{
    var result: AddAccountResult = .failure(.unexpected)
    var input: AddAccountInput?
    var callsCount: Int = 0

    func handle(input: AddAccountInput) async -> AddAccountResult {
        self.callsCount += 1
        self.input = input
        return self.result
    }

    func resultDefined(with result: AddAccountResult){
        self.result = result
    }
}
