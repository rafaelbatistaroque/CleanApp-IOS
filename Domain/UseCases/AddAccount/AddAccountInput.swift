import Foundation
public struct AddAccountInput: InputAggregatorProtocol {
    public let name: String
    public let email: String
    public let password: String
    public let passwordConfirmation: String
    
    public init(name: String, email: String, password: String, passwordConfirmation: String) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
