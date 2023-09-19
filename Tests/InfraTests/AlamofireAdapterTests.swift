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
                dataReturned: nil,
                response: nil,
                error: fakeError(),
                expectedResult: .failure(.noConnectivity))])
        
        for testCase in testCases {
            UrlProtocolStub.simulateResponse(dataReturned: testCase.dataReturned, response: testCase.response, error: testCase.error)
            
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
                (dataReturned: fakeValidData(), response: fakeUrlResponse(), error: fakeError(), expectedResult: .failure(.noConnectivity)),
                (dataReturned: fakeValidData(), response: nil, error: fakeError(), expectedResult: .failure(.noConnectivity)),
                (dataReturned: fakeValidData(), response: nil, error: nil, expectedResult: .failure(.noConnectivity)),
                (dataReturned: nil, response: fakeUrlResponse(), error: fakeError(), expectedResult: .failure(.noConnectivity)),
                (dataReturned: nil, response: fakeUrlResponse(), error: nil, expectedResult: .failure(.noConnectivity)),
                (dataReturned: nil, response: nil, error: nil, expectedResult: .failure(.noConnectivity)),
            ])
        
        for testCase in testCases {
            UrlProtocolStub.simulateResponse(dataReturned: testCase.dataReturned, response: testCase.response, error: testCase.error)
            
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
        let dataReturned = fakeValidData()
        let testCases = createResponseTestCases(
            withConditions: [
                (dataReturned: dataReturned, response: fakeUrlResponse(), error: nil, expectedResult: .success(dataReturned)),
            ])
        
        for testCase in testCases {
            UrlProtocolStub.simulateResponse(dataReturned: testCase.dataReturned, response: testCase.response, error: testCase.error)
            
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
                (dataReturned: nil, response: fakeUrlResponse(statusCode: 204), error: nil, expectedResult: .success(nil)),
                (dataReturned: fakeEmptyData(), response: fakeUrlResponse(statusCode: 204), error: nil, expectedResult: .success(nil)),
                (dataReturned: fakeValidData(), response: fakeUrlResponse(statusCode: 204), error: nil, expectedResult: .success(nil)),
            ])
        
        for testCase in testCases {
            UrlProtocolStub.simulateResponse(dataReturned: testCase.dataReturned, response: testCase.response, error: testCase.error)
            
            //act
            let result = await sut.post(to: url, with: fakeValidData())
            
            //assert
            expect(
                should: result,
                beEqual: testCase.expectedResult)
        }
    }
    
    func test_givenAlamofireAdapterRequest_whenPostStatusCodeNon200_thenEnsureResponseWithError() async {
        //arrange
        let (sut, url) = createSUT()
        let testCases = createResponseTestCases(
            withConditions: [
                (dataReturned: fakeValidData(), response: fakeUrlResponse(statusCode: 400), error: nil, expectedResult: .failure(.badRequest)),
                (dataReturned: fakeValidData(), response: fakeUrlResponse(statusCode: 401), error: nil, expectedResult: .failure(.unauthorized)),
                (dataReturned: fakeValidData(), response: fakeUrlResponse(statusCode: 403), error: nil, expectedResult: .failure(.forbidden)),
                (dataReturned: fakeValidData(), response: fakeUrlResponse(statusCode: 500), error: nil, expectedResult: .failure(.serverError)),
                (dataReturned: fakeValidData(), response: fakeUrlResponse(statusCode: 300), error: nil, expectedResult: .failure(.noConnectivity)),
            ])
        
        for testCase in testCases {
            UrlProtocolStub.simulateResponse(dataReturned: testCase.dataReturned, response: testCase.response, error: testCase.error)
            
            //act
            let result = await sut.post(to: url, with: fakeValidData())
            
            //assert
            expect(
                should: result,
                beEqual: testCase.expectedResult)
        }
    }
}
