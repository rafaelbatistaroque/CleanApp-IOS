import Foundation
import Domain

extension CompareFieldsValidationTests {
    func createSUT(fieldName: String, fieldNameToCompare: String, fieldLabel:String) -> CompareFieldValidation {
        return CompareFieldValidation(fieldName: fieldName, fieldNameToCompare: fieldNameToCompare, fieldLabel: fieldLabel)
    }
}

