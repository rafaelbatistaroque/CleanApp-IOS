import Foundation
import Shared

public struct AddAccountViewModel: DTOProtocol {
    public let name: String?
    public let email: String?
    public let password: String?
    public let passwordConfirmation: String?

    public init(name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
