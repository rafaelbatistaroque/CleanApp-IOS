import Foundation

public final class RequiredFieldValidation: ValidateProtocol, Equatable{
    private var errors: [String] = []
    public let fieldName: String
    public let fieldLabel: String

    public init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }

    public func validate(data: [String : Any]?) -> [String] {
        self.errors = []

        guard let fieldName = data?[fieldName] as? String, fieldName.isEmpty == false else {
            self.errors.append("O campo \(self.fieldLabel) é obrigatório")

            return self.errors
        }

        return self.errors
    }
}

extension RequiredFieldValidation {
    public static func == (lhs: RequiredFieldValidation, rhs: RequiredFieldValidation) -> Bool {
        (lhs as AnyObject).hash == (rhs as AnyObject).hash
    }
}
