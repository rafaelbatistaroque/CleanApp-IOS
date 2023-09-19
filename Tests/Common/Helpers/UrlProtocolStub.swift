import Foundation

class UrlProtocolStub: URLProtocol{
    static var request: URLRequest?
    static var response: (dataReturned: Data?, response: HTTPURLResponse?, error: Error?)

    static func simulateResponse(dataReturned: Data?, response: HTTPURLResponse?, error: Error?){
        UrlProtocolStub.response = (dataReturned, response, error)
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override open func startLoading() {
        UrlProtocolStub.request = request
        
        let (dataReturned, response, error) = UrlProtocolStub.response
        if let data = dataReturned {
            client?.urlProtocol(self, didLoad: data)
        }

        if let response = response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override open func stopLoading() {}
}
