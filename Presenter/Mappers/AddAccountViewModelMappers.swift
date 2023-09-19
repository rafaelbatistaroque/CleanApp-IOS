import Foundation
import Domain
import Shared

public extension AddAccountViewModel {
    static func == (lhs: AddAccountViewModel, rhs: AddAccountViewModel) -> Bool {
        (lhs as AnyObject).hash == (rhs as AnyObject).hash
    }

     func toAddAccountInput() -> AddAccountInput {
         AddAccountInput(
            name: self.name,
            email: self.email,
            password: self.password,
            passwordConfirmation: self.passwordConfirmation)
    }
}
