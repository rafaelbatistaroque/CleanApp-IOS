import Foundation

class UrlProtocolStub: URLProtocol{
    static var request: URLRequest?
    static var response: (data: Data?, response: HTTPURLResponse?, error: Error?)

    static func simulateResponse(data: Data?, response: HTTPURLResponse?, error: Error?){
        UrlProtocolStub.response = (data, response, error)
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override open func startLoading() {
        UrlProtocolStub.request = request
        
        let (data, response, error) = UrlProtocolStub.response
        if let data = data {
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
