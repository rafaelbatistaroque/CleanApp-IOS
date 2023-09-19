import Foundation
import Shared

public struct AddAccountOutput : DTOProtocol{
    public let accessToken: String

    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
