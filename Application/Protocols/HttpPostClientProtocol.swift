import Foundation

public protocol HttpPostClientProtocol{
    func post(to url: URL, with data: Data?) async -> Result<Data?, HttpError>
}
