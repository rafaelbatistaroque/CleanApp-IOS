import Foundation

public final class EmailValidation: ValidateProtocol, Equatable {
    public let fieldName:String
    public let fieldLabel:String
    private var errors:[String] = []

    public init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }

    private func isValid(email:String) -> Bool {
        let emailPattern = /^([\d\w\S]+)@(\w{2,}\.\w{2,}?)(\.[\w\S\D]{2})?$/

        return (try? emailPattern.wholeMatch(in: email)) != nil
    }

    public func validate(data: [String : Any]?) -> [String] {
        self.errors = []

        guard
            let fieldNameValue = data?[self.fieldName] as? String,
            isValid(email: fieldNameValue) else {

            self.errors.append("O campo \(self.fieldLabel) é inválido")

            return self.errors
        }

        return self.errors
    }
}

extension EmailValidation {
    public static func == (lhs: EmailValidation, rhs: EmailValidation) -> Bool {
        (lhs as AnyObject).hash == (rhs as AnyObject).hash
    }
}
