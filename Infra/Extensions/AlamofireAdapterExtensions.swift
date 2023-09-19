import Foundation
import Application
import Alamofire

extension AlamofireAdapter {
    func makeURLRequest(to url: URL, method verb: HTTPMethod = .get, with data: Data?, headers: [HTTPHeader] = []) -> URLRequest {
        var httpRequest = URLRequest(url: url)
        httpRequest.httpBody = data
        httpRequest.method = verb
        httpRequest.headers = HTTPHeaders(headers)
        
        return httpRequest
    }
    
    func statucCodeResponseHandler(for code:Int, data: Data) -> Result<Data?, HttpError> {
        switch code {
            case 204:
                return .success(nil)
            case 200...299:
                return .success(data)
            case 401:
                return .failure(.unauthorized)
            case 403:
                return .failure(.forbidden)
            case 400...499:
                return .failure(.badRequest)
            case 500...599:
                return .failure(.serverError)
            default:
                return .failure(.noConnectivity)
        }
    }
}
