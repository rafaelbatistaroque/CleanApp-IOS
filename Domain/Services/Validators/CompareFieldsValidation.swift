import Foundation

public final class CompareFieldValidation: ValidateProtocol, Equatable{
    private var errors: [String] = []
    public let fieldName: String
    public let fieldNameToCompare: String
    public let fieldLabel: String

    public init(fieldName: String, fieldNameToCompare: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
        self.fieldLabel = fieldLabel
    }

    public func validate(data: [String : Any]?) -> [String] {
        self.errors = []

        guard
            let fieldName = data?[self.fieldName] as? String,
            let fieldNameToCompare = data?[self.fieldNameToCompare] as? String,
            fieldName == fieldNameToCompare else {

            self.errors.append("O campo \(fieldLabel) é inválido")

            return self.errors
        }

        return self.errors
    }
}

extension CompareFieldValidation {
    public static func == (lhs: CompareFieldValidation, rhs: CompareFieldValidation) -> Bool {
        (lhs as AnyObject).hash == (rhs as AnyObject).hash
    }
}
