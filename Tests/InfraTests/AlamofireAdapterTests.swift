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
        
        let responseData = await self.session.request(request).serializingData().response
        
        guard responseData.response?.statusCode != nil else {
            return .failure(.noConnectivity)
        }
        
        switch responseData.result {
        case .failure:
            return .failure(.noConnectivity)
        case .success(let data):
            return .success(data)
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
    
    func test_givenAlamofireAdapterRequest_whenPostWithError_thenEnsureResponseWithError() async {
        //arrange
        let (sut, url) = createSUT()
        let caseTests = createCaseTestsList(
            withExpectedConditions: [(
                data: nil,
                response: nil,
                error: fakeError(),
                expectedResult: .failure(.noConnectivity))])
        
        for item in caseTests {
            UrlProtocolStub.simulate(data: item.data, response: item.response, error: item.error)
            
            //act
            let result = await sut.post(to: url, with: fakeValidData())
            
            //assert
            expect(
                should: result,
                beEqual: item.expectedResult)
        }
    
    }
    
    func test_givenAlamofireAdapterRequest_whenPostWithInvalidCases_thenEnsureResponseWithSpecificError() async {
        //arrange
        let (sut, url) = createSUT()
        let caseTests = createCaseTestsList(
            withExpectedConditions: [
                (data: fakeValidData(), response: fakeUrlResponse(), error: fakeError(), expectedResult: .failure(.noConnectivity)),
                (data: fakeValidData(), response: nil, error: fakeError(), expectedResult: .failure(.noConnectivity)),
                (data: fakeValidData(), response: nil, error: nil, expectedResult: .failure(.noConnectivity)),
                (data: nil, response: fakeUrlResponse(), error: fakeError(), expectedResult: .failure(.noConnectivity)),
                (data: nil, response: fakeUrlResponse(), error: nil, expectedResult: .failure(.noConnectivity)),
                (data: nil, response: nil, error: nil, expectedResult: .failure(.noConnectivity)),
            ])
        
        for item in caseTests {
            UrlProtocolStub.simulate(data: item.data, response: item.response, error: item.error)
            
            //act
            let result = await sut.post(to: url, with: fakeValidData())
            
            //assert
            expect(
                should: result,
                beEqual: item.expectedResult)
        }
    
    }
}
