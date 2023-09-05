import Foundation
import Alamofire

extension AlamofireAdapterTests {
    func createSUT() -> (AlamofireAdapter, URL){
        return (
            AlamofireAdapter(
            session: Session(configuration: createSessionConfiguration())),
            fakeURL())
    }
    
    private func createSessionConfiguration() -> URLSessionConfiguration{
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        configuration.timeoutIntervalForRequest = TimeInterval(0.1)
        
        return configuration
    }
}
