import Foundation

public extension Data {
    func toDTO<T: DTOProtocol>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
