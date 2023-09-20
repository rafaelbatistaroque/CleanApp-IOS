import Foundation
import Shared

public struct AuthenticationOutput : DTOProtocol{
    public let accessToken: String

    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
