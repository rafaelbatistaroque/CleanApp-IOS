import Foundation

public enum DomainError: Error, Equatable{
    case unexpected,
    emailInUse
}
