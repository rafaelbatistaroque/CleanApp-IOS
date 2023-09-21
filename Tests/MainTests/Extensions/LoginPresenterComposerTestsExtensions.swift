import Foundation
import Domain
import Main

extension LoginPresenterComposerTests {
    func createSUT() -> ([ValidateProtocol], [RequiredFieldValidation], [EmailValidation], Int){

        let expectedRequiredValidation =  [
            RequiredFieldValidation(fieldName: "email", fieldLabel: "E-mail"),
            RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
        ]
        let expectedEmailValidation = [
            EmailValidation(fieldName: "email", fieldLabel: "E-mail")
        ]

        let expectedTotalValidations = [
            expectedRequiredValidation.count,
            expectedEmailValidation.count].reduce(0, +)

        return (
            LoginPresenterComposer.makeValidations(),
            expectedRequiredValidation,
            expectedEmailValidation,
            expectedTotalValidations
        )
    }
}
