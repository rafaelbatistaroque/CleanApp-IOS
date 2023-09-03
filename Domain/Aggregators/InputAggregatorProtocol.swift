import Foundation

public protocol InputAggregatorProtocol: Encodable {}

public extension InputAggregatorProtocol {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
