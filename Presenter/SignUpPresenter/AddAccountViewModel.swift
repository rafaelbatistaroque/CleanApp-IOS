import Foundation
import Shared

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
}
