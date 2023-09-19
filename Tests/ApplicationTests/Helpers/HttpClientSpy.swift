import Foundation
import Application
import Shared

class HttpClientSpy: HttpPostClientProtocol{
    var urls = [URL]()
    var data: Data? = nil
    var result: Result<Data?, HttpError> = .failure(HttpError.noConnectivity)
    
    func post(to url: URL, with data: Data?) async -> Result<Data?, HttpError> {
        self.urls.append(url)
        self.data = data

        return result
    }
    
    func resultDefined(with result: Result<Data?, HttpError>){
        self.result = result
    }
}

extension WeakVarProxy:HttpPostClientProtocol where T: HttpPostClientProtocol{
    public func post(to url: URL, with data: Data?) async -> Result<Data?, HttpError> {
        await instance?.post(to: url, with: data) ?? .failure(.noConnectivity)
    }
}
