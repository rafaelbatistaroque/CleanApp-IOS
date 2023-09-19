import Foundation
import Domain

extension RequiredFieldValidationTests {
    func createSUT(fieldName: String, fieldLabel:String) -> RequiredFieldValidation {
        return RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
    }
}
