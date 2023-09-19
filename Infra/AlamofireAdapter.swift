import Foundation
import Alamofire
import Application
import Shared

final public class AlamofireAdapter : HttpPostClientProtocol {
    @Inject private var session: Session
    
    public init() { }
    
    public func post(to url: URL, with data: Data? = nil) async -> Result<Data?, HttpError> {
        let request = makeURLRequest(
            to: url,
            method: .post,
            with: data)

//        try? await Task.sleep(nanoseconds: 5_000_000)
        let responseData = await self.session.request(request).serializingData().response

        guard let statusCode = responseData.response?.statusCode else {
            return .failure(.noConnectivity)
        }
        
        switch responseData.result {
        case .failure:
            return .failure(.noConnectivity)
        case .success(let successData):
            return statucCodeResponseHandler(for: statusCode, data: successData)
        }
    }
}
