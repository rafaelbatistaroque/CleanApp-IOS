import Foundation
import Alamofire
import Presenter
import Shared
import Application
import Domain

public final class LoginPresenterComposer{
    static func factory() -> LoginPresenter {
        let validationComposites = ValidationComposite(validations: makeValidations())
        @Provider var autenticationProvided = UseCasesFactory.remoteAutenticationfactory() as AuthenticationProtocol
        @Provider var validationCompositesProvided = validationComposites as ValidateProtocol

        return LoginPresenter()
    }

    public static func makeValidations() -> [ValidateProtocol]{
        return [
            RequiredFieldValidation(fieldName: "email", fieldLabel: "E-mail"),
            EmailValidation(fieldName: "email", fieldLabel: "E-mail"),
            RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha")
        ]
    }
}
