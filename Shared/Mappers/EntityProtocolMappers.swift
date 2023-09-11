import Foundation

public extension EntityProtocol {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
