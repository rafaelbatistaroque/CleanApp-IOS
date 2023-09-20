import Foundation
import Domain
import Shared

public class AuthenticationViewModel: DTOProtocol{
    public var email: String? = nil
    public var password: String? = nil

    public init(email: String? = nil, password: String? = nil) {
        self.email = email
        self.password = password
    }

    public func toAuthenticationInput() -> AuthenticationInput {
        AuthenticationInput(
            email: self.email,
            password: self.password)
    }
}

extension AuthenticationViewModel {
    public static func == (lhs: AuthenticationViewModel, rhs: AuthenticationViewModel) -> Bool {
        (lhs as AnyObject).hash == (rhs as AnyObject).hash
    }
}
