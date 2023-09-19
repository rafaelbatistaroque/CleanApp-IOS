import Foundation
import Shared
import Domain

public class AddAccountViewModel: ObservableObject, DTOProtocol {
    public var name: String? = nil
    public var email: String? = nil
    public var password: String? = nil
    public var passwordConfirmation: String? = nil

    public init(name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }

    public func toAddAccountInput() -> AddAccountInput {
        AddAccountInput(
            name: self.name,
            email: self.email,
            password: self.password,
            passwordConfirmation: self.passwordConfirmation)
    }
}


extension AddAccountViewModel{
    public static func == (lhs: AddAccountViewModel, rhs: AddAccountViewModel) -> Bool {
        (lhs as AnyObject).hash == (rhs as AnyObject).hash
    }
}
