import Foundation

class UrlProtocolStub: URLProtocol{
    static var request: URLRequest?

    override open class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override open func startLoading() {
        UrlProtocolStub.request = request
    }
    
    override open func stopLoading() {}
}
