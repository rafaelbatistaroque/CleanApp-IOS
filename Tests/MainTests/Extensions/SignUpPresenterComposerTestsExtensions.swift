import Foundation
import Domain
import Main

extension SignUpPresenterComposerTests {
    func createSUT() -> ([ValidateProtocol], [RequiredFieldValidation], [EmailValidation], [CompareFieldValidation], Int){

        let expectedRequiredValidation =  [
            RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"),
            RequiredFieldValidation(fieldName: "email", fieldLabel: "E-mail"),
            RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
            RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmação de Senha"),
        ]
        let expectedEmailValidation = [
            EmailValidation(fieldName: "email", fieldLabel: "E-mail")
        ]
        let expectedCompareValidation = [
            CompareFieldValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
        ]

        let expectedTotalValidations = [
            expectedRequiredValidation.count,
            expectedEmailValidation.count,
            expectedCompareValidation.count].reduce(0, +)

        return (
            SignUpPresenterComposer.makeValidations(),
            expectedRequiredValidation,
            expectedEmailValidation,
            expectedCompareValidation,
            expectedTotalValidations
        )
    }
}
