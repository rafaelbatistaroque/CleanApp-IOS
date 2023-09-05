import Foundation
import Application

class HttpClientSpy: HttpPostClientProtocol{
    var urls = [URL]()
    var inputData: Data?
    var result: Result<Data, HttpError> = .failure(HttpError.noConnectivity)
    
    func post(to url: URL, with data: Data?) async -> Result<Data, HttpError> {
        self.urls.append(url)
        self.inputData = data
        
        return result
    }
    
    func result(with result: Result<Data, HttpError>){
        self.result = result
    }
}
