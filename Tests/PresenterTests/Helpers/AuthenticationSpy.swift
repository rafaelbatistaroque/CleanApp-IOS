import Foundation
import Domain
import Shared

class AuthenticationSpy: AuthenticationProtocol{
    var result: AuthenticationResult = .failure(.unexpected)
    var input: AuthenticationInput?
    var callsCount: Int = 0

    func handle(input: AuthenticationInput) async -> AuthenticationResult {
        self.callsCount += 1
        self.input = input

        return self.result
    }

    func resultDefined(with result: AuthenticationResult){
        self.result = result
    }
}
