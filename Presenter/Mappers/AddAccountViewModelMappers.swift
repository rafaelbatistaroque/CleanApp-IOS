import Foundation
import Domain

public extension AddAccountViewModel {
     func toAddAccountInput() -> AddAccountInput {
         AddAccountInput(
            name: self.name,
            email: self.email,
            password: self.password,
            passwordConfirmation: self.passwordConfirmation)
    }
}
