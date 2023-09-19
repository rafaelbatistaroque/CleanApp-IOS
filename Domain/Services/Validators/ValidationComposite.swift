import Foundation

public final class ValidationComposite:ValidateProtocol, Equatable{
    private let validations:[ValidateProtocol]
    private var errors:[String] = []

    public init(validations: [ValidateProtocol]) {
        self.validations = validations
    }

    public func validate(data: [String : Any]?) -> [String] {
        self.errors = []
        for validation in self.validations {
            let errorMessages = validation.validate(data: data)
            if errorMessages.isEmpty == false {
                self.errors.append(contentsOf: errorMessages)
            }
        }

        return self.errors
    }
}

extension ValidationComposite {
    public static func == (lhs: ValidationComposite, rhs: ValidationComposite) -> Bool {
        (lhs as AnyObject).hash == (rhs as AnyObject).hash
    }
}
