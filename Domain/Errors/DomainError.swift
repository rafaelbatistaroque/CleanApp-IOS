import Foundation

public enum DomainError: Error, Equatable{
    case unexpected, validate(withMessage: [String])

    public var validateMessage: [String]? {
        switch self {
            case .validate(withMessage: let message):
                return message
            default:
                return nil
        }
    }
}
