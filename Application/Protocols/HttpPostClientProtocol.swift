import Foundation

public protocol HttpPostClientProtocol{
    func post(to url: URL, with content: Data?) async -> Result<Data, HttpError>
}
