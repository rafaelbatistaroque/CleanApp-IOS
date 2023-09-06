import XCTest
import Application
import Alamofire

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
    
    func test_givenAlamofireAdapterRequest_whenFailPost_thenEnsureResponseWithError() async {
        //arrange
        let (sut, url) = createSUT()
        let testCases = createResponseTestCases(
            withConditions: [(
                data: nil,
                response: nil,
                error: fakeError(),
                expectedResult: .failure(.noConnectivity))])
        
        for testCase in testCases {
            UrlProtocolStub.simulateResponse(data: testCase.data, response: testCase.response, error: testCase.error)
            
            //act
            let result = await sut.post(to: url, with: fakeValidData())
            
            //assert
            expect(
                should: result,
                beEqual: testCase.expectedResult)
        }
    }
    
    func test_givenAlamofireAdapterRequest_whenPostWithInvalidCases_thenEnsureResponseWithError() async {
        //arrange
        let (sut, url) = createSUT()
        let testCases = createResponseTestCases(
            withConditions: [
                (data: fakeValidData(), response: fakeUrlResponse(), error: fakeError(), expectedResult: .failure(.noConnectivity)),
                (data: fakeValidData(), response: nil, error: fakeError(), expectedResult: .failure(.noConnectivity)),
                (data: fakeValidData(), response: nil, error: nil, expectedResult: .failure(.noConnectivity)),
                (data: nil, response: fakeUrlResponse(), error: fakeError(), expectedResult: .failure(.noConnectivity)),
                (data: nil, response: fakeUrlResponse(), error: nil, expectedResult: .failure(.noConnectivity)),
                (data: nil, response: nil, error: nil, expectedResult: .failure(.noConnectivity)),
            ])
        
        for testCase in testCases {
            UrlProtocolStub.simulateResponse(data: testCase.data, response: testCase.response, error: testCase.error)
            
            //act
            let result = await sut.post(to: url, with: fakeValidData())
            
            //assert
            expect(
                should: result,
                beEqual: testCase.expectedResult)
        }
    }
    
    func test_givenAlamofireAdapterRequest_whenPostStatusCode200_thenEnsureResponseWithData() async {
        //arrange
        let (sut, url) = createSUT()
        let testCases = createResponseTestCases(
            withConditions: [
                (data: fakeValidData(), response: fakeUrlResponse(), error: nil, expectedResult: .success(fakeValidData())),
            ])
        
        for testCase in testCases {
            UrlProtocolStub.simulateResponse(data: testCase.data, response: testCase.response, error: testCase.error)
            
            //act
            let result = await sut.post(to: url, with: fakeValidData())
            
            //assert
            expect(
                should: result,
                beEqual: testCase.expectedResult)
        }
    }
    
    func test_givenAlamofireAdapterRequest_whenPostStatusCode204_thenEnsureResponseWithNoData() async {
        //arrange
        let (sut, url) = createSUT()
        let testCases = createResponseTestCases(
            withConditions: [
                (data: nil, response: fakeUrlResponse(withStatusCode: 204), error: nil, expectedResult: .success(nil)),
                (data: fakeEmptyData(), response: fakeUrlResponse(withStatusCode: 204), error: nil, expectedResult: .success(nil)),
                (data: fakeValidData(), response: fakeUrlResponse(withStatusCode: 204), error: nil, expectedResult: .success(nil)),
            ])
        
        for testCase in testCases {
            UrlProtocolStub.simulateResponse(data: testCase.data, response: testCase.response, error: testCase.error)
            
            //act
            let result = await sut.post(to: url, with: fakeValidData())
            
            //assert
            expect(
                should: result,
                beEqual: testCase.expectedResult)
        }
    }
    
    func test_givenAlamofireAdapterRequest_whenPostStatusCodeNo200_thenEnsureResponseWithError() async {
        //arrange
        let (sut, url) = createSUT()
        let testCases = createResponseTestCases(
            withConditions: [
                (data: fakeValidData(), response: fakeUrlResponse(withStatusCode: 400), error: nil, expectedResult: .failure(.badRequest)),
                (data: fakeValidData(), response: fakeUrlResponse(withStatusCode: 401), error: nil, expectedResult: .failure(.unauthorized)),
                (data: fakeValidData(), response: fakeUrlResponse(withStatusCode: 403), error: nil, expectedResult: .failure(.forbidden)),
                (data: fakeValidData(), response: fakeUrlResponse(withStatusCode: 500), error: nil, expectedResult: .failure(.serverError)),
            ])
        
        for testCase in testCases {
            UrlProtocolStub.simulateResponse(data: testCase.data, response: testCase.response, error: testCase.error)
            
            //act
            let result = await sut.post(to: url, with: fakeValidData())
            
            //assert
            expect(
                should: result,
                beEqual: testCase.expectedResult)
        }
    }
}
