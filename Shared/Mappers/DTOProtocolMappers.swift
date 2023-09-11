import Foundation

public extension DTOProtocol {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
