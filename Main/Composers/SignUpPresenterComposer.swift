import Foundation
import Alamofire
import Presenter
import Shared
import Application
import Domain

public final class SignUpPresenterComposer{
    static func factory() -> SignUpPresenter {
        let validationComposites = ValidationComposite(validations: makeValidations())
        @Provider var addAccountProvided = UseCasesFactory.remoteAddAccountfactory() as AddAccountProtocol
        @Provider var validationCompositesProvided = validationComposites as ValidateProtocol

        return SignUpPresenter()
    }

    public static func makeValidations() -> [ValidateProtocol]{
        return [
            RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"),
            RequiredFieldValidation(fieldName: "email", fieldLabel: "E-mail"),
            EmailValidation(fieldName: "email", fieldLabel: "E-mail"),
            RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
            RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmação de Senha"),
            CompareFieldValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
        ]
    }
}
