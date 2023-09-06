import XCTest
import Application
import Alamofire

class AlamofireAdapter{
    private let session:Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data? = nil) async -> Result<Data, HttpError> {
        let request = makeURLRequest(
            to: url,
            method: .post,
            with: data)

        let response = await self.session.request(request).serializingData().response
        
        switch response.result {
        case .failure:
            return .failure(.noConnectivity)
        case .success:
            return .success(Data())
        }
    }
}

extension AlamofireAdapter {
    func makeURLRequest(to url: URL, method verb: HTTPMethod = .get, with data: Data?, headers: [HTTPHeader] = []) -> URLRequest {
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
        _ = await sut.post(to: url)

        //assert
        expect(
            should: UrlProtocolStub.request?.url,
            beEqual: url)
    }
    
    func test_givenAlamofireAdapterRequest_whenPost_thenEnsureCallsWithCorrectVerb() async{
        //arrange
        let (sut, url) = createSUT()
        
        //act
        _ = await sut.post(to: url)

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
        _ = await sut.post(to: url, with: validData)

        //assert
        expect(
            shouldNotBeNil: UrlProtocolStub.request?.httpBodyStream)
    }
    
    func test_givenAlamofireAdapterRequest_whenPostWithoutBody_thenEnsureCallsWithEmptyData() async{
        //arrange
        let (sut, url) = createSUT()
        
        //act
        _ = await sut.post(to: url, with: nil)

        //assert
        expect(
            shouldBeNil: UrlProtocolStub.request?.httpBodyStream)
    }
    
    func test_givenAlamofireAdapterRequest_whenPostWithError_thenEnsureResponseWithError() async{
        //arrange
        let (sut, url) = createSUT()
        UrlProtocolStub.simulate(data: nil, response: nil, error: fakeError())
        
        //act
        let result = await sut.post(to: url, with: fakeValidData())

        //assert
        expect(
            should: result,
            beEqual: .failure(.noConnectivity))
    }
}
