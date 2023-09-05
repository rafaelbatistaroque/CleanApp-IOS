import XCTest
import Alamofire

class AlamofireAdapter{
    private let session:Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data? = nil) async -> Void {
        let request = makeRequest(
            to: url,
            method: .post,
            with: data)

        _ = await self.session.request(request).serializingString().response
    }
    
    private func makeRequest(to url: URL, method verb: HTTPMethod = .get, with data: Data?, headers: [HTTPHeader] = []) -> URLRequest {
        var httpRequest = URLRequest(url: url)
        httpRequest.httpBody = data
        httpRequest.method = verb
        httpRequest.headers = HTTPHeaders(headers)

        return httpRequest
    }
}

final class AlamofireAdapterTests: XCTestCase {
    func test_givenAlamofireAdapterRequest_whenPost_thenEnsureCallsWithCorrectUrl() async{
        //arrange
        let (sut, url) = createSUT()
        
        //act
        await sut.post(to: url)

        //assert
        expect(
            should: UrlProtocolStub.request?.url,
            beEqual: url)
    }
    
    func test_givenAlamofireAdapterRequest_whenPost_thenEnsureCallsWithCorrectVerb() async{
        //arrange
        let (sut, url) = createSUT()
        
        //act
        await sut.post(to: url)

        //assert
        expect(
            should: UrlProtocolStub.request?.method,
            beEqual: HTTPMethod.post)
    }
    
    func test_givenAlamofireAdapterRequest_whenPostWithBody_thenEnsureCallsWithValidData() async{
        //arrange
        let (sut, url) = createSUT()
        let validData = fakeValidData()
        
        //act
        await sut.post(to: url, with: validData)

        //assert
        expect(
            shouldNotBeNil: UrlProtocolStub.request?.httpBodyStream)
    }
    
    func test_givenAlamofireAdapterRequest_whenPostWithoutBody_thenEnsureCallsWithEmptyData() async{
        //arrange
        let (sut, url) = createSUT()
        
        //act
        await sut.post(to: url, with: nil)

        //assert
        expect(
            shouldBeNil: UrlProtocolStub.request?.httpBodyStream)
    }
}

extension AlamofireAdapterTests {
    func createSUT() -> (AlamofireAdapter, URL){
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        configuration.timeoutIntervalForRequest = TimeInterval(0.1)
        let session = Session(configuration: configuration)

        return (AlamofireAdapter(session: session), fakeURL())
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
