import Foundation
import Domain

extension EmailValidationTests{
    func createSUT(fieldName: String, fieldLabel: String) -> EmailValidation {

        return EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel)
    }
}
