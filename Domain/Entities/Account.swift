import Foundation
import Shared

public struct Account: EntityProtocol {
    public let name: String
    public let email: String
    public let password: String
    public let passwordConfirmation: String

    public static func make(input:AddAccountInput) -> Result<Account, DomainError> {
        let validation = EntityValidate
            .init()
            .isNullOrEmpty(field: input.name, message: AddAccountInputErrorMessage.requiredName.rawValue)
            .isNullOrEmpty(field: input.email, message: AddAccountInputErrorMessage.requiredEmail.rawValue)
            .isNullOrEmpty(field: input.password, message: AddAccountInputErrorMessage.requiredPassword.rawValue)
            .isNullOrEmpty(field: input.passwordConfirmation, message: AddAccountInputErrorMessage.requiredPasswordConfirmation.rawValue)
            .isNotEquals(fieldOne: input.password, fieldTwo: input.passwordConfirmation, message: AddAccountInputErrorMessage.failPasswordConfirmation.rawValue)

        if let erro = validation.hasError ? validation.getErrors() : nil{
            return .failure(.validate(withMessage: erro))
        }

        return .success(Account(name: input.name!, email: input.email!, password: input.password!, passwordConfirmation: input.passwordConfirmation!))
    }

    init(name: String, email: String, password: String, passwordConfirmation: String) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
