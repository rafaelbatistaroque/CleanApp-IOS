import XCTest
import Alamofire

class AlamofireAdapter{
    private let session:Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL) async -> Void {
        _ = await self.session.request(url, method: .post).serializingString().response
    }
}

final class AlamofireAdapterTests: XCTestCase {
    func test_givenAlamofireAdapterRequest_whenPost_thenEnsureCallsWithCorrectUrl() async{
        //arrange
        let url = fakeURL()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        configuration.timeoutIntervalForRequest = TimeInterval(0.1)
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session);
        
        //act
        await sut.post(to: url)

        //assert
        expect(
            should: UrlProtocolStub.request?.url,
            beEqual: url)
    }
    
    func test_givenAlamofireAdapterRequest_whenPost_thenEnsureCallsWithCorrectVerb() async{
        //arrange
        let url = fakeURL()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        configuration.timeoutIntervalForRequest = TimeInterval(0.1)
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session);
        
        //act
        await sut.post(to: url)

        //assert
        expect(
            should: UrlProtocolStub.request?.method,
            beEqual: HTTPMethod.post)
    }
}

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
