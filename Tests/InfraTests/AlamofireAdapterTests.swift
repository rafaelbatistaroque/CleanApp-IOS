import XCTest
import Application
import Alamofire

class AlamofireAdapter : HttpPostClientProtocol {
    private let session:Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func post(to url: URL, with data: Data? = nil) async -> Result<Data?, HttpError> {
        let request = makeURLRequest(
            to: url,
            method: .post,
            with: data)
        
        let responseData = await self.session.request(request).serializingData().response
        
        guard let statusCode = responseData.response?.statusCode else {
            return .failure(.noConnectivity)
        }
        
        switch responseData.result {
        case .failure:
            return .failure(.noConnectivity)
        case .success(let data):
            switch statusCode{
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
        let testCases = createCaseTestsList(
            withExpectedConditions: [(
                data: nil,
                response: nil,
                error: fakeError(),
                expectedResult: .failure(.noConnectivity))])
        
        for item in testCases {
            UrlProtocolStub.simulate(data: item.data, response: item.response, error: item.error)
            
            //act
            let result = await sut.post(to: url, with: fakeValidData())
            
            //assert
            expect(
                should: result,
                beEqual: item.expectedResult)
        }
    
    }
    
    func test_givenAlamofireAdapterRequest_whenPostWithInvalidCases_thenEnsureResponseWithError() async {
        //arrange
        let (sut, url) = createSUT()
        let testCases = createCaseTestsList(
            withExpectedConditions: [
                (data: fakeValidData(), response: fakeUrlResponse(), error: fakeError(), expectedResult: .failure(.noConnectivity)),
                (data: fakeValidData(), response: nil, error: fakeError(), expectedResult: .failure(.noConnectivity)),
                (data: fakeValidData(), response: nil, error: nil, expectedResult: .failure(.noConnectivity)),
                (data: nil, response: fakeUrlResponse(), error: fakeError(), expectedResult: .failure(.noConnectivity)),
                (data: nil, response: fakeUrlResponse(), error: nil, expectedResult: .failure(.noConnectivity)),
                (data: nil, response: nil, error: nil, expectedResult: .failure(.noConnectivity)),
            ])
        
        for item in testCases {
            UrlProtocolStub.simulate(data: item.data, response: item.response, error: item.error)
            
            //act
            let result = await sut.post(to: url, with: fakeValidData())
            
            //assert
            expect(
                should: result,
                beEqual: item.expectedResult)
        }
    
    }
    
    func test_givenAlamofireAdapterRequest_whenPostStatusCode200_thenEnsureResponseWithData() async {
        //arrange
        let (sut, url) = createSUT()
        let testCases = createCaseTestsList(
            withExpectedConditions: [
                (data: fakeValidData(), response: fakeUrlResponse(), error: nil, expectedResult: .success(fakeValidData())),
            ])
        
        for item in testCases {
            UrlProtocolStub.simulate(data: item.data, response: item.response, error: item.error)
            
            //act
            let result = await sut.post(to: url, with: fakeValidData())
            
            //assert
            expect(
                should: result,
                beEqual: item.expectedResult)
        }
    
    }
    
    func test_givenAlamofireAdapterRequest_whenPostStatusCode204_thenEnsureResponseWithNoData() async {
        //arrange
        let (sut, url) = createSUT()
        let testCases = createCaseTestsList(
            withExpectedConditions: [
                (data: nil, response: fakeUrlResponse(withStatusCode: 204), error: nil, expectedResult: .success(nil)),
                (data: fakeEmptyData(), response: fakeUrlResponse(withStatusCode: 204), error: nil, expectedResult: .success(nil)),
                (data: fakeValidData(), response: fakeUrlResponse(withStatusCode: 204), error: nil, expectedResult: .success(nil)),
            ])
        
        for item in testCases {
            UrlProtocolStub.simulate(data: item.data, response: item.response, error: item.error)
            
            //act
            let result = await sut.post(to: url, with: fakeValidData())
            
            //assert
            expect(
                should: result,
                beEqual: item.expectedResult)
        }
    
    }
    
    func test_givenAlamofireAdapterRequest_whenPostStatusCodeNo200_thenEnsureResponseWithError() async {
        //arrange
        let (sut, url) = createSUT()
        let testCases = createCaseTestsList(
            withExpectedConditions: [
                (data: fakeValidData(), response: fakeUrlResponse(withStatusCode: 400), error: nil, expectedResult: .failure(.badRequest)),
                (data: fakeValidData(), response: fakeUrlResponse(withStatusCode: 401), error: nil, expectedResult: .failure(.unauthorized)),
                (data: fakeValidData(), response: fakeUrlResponse(withStatusCode: 403), error: nil, expectedResult: .failure(.forbidden)),
                (data: fakeValidData(), response: fakeUrlResponse(withStatusCode: 500), error: nil, expectedResult: .failure(.serverError)),
            ])
        
        for item in testCases {
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
