import Foundation
import Infra
import Application
import Alamofire
import Shared

extension AlamofireAdapterTests {
    func createResponseTestCases(withConditions items:[(dataReturned: Data?, response: HTTPURLResponse?, error: Error?, expectedResult: Result<Data?, HttpError>)])
        -> Array<(dataReturned: Data?, response: HTTPURLResponse?, error: Error?, expectedResult: Result<Data?, HttpError>)> {
        
            Array<(dataReturned: Data?, response: HTTPURLResponse?, error: Error?, expectedResult: Result<Data?, HttpError>)>(items)
    }
    
    func createSUT(file: StaticString = #filePath, line: UInt = #line) -> (AlamofireAdapter, URL){
        @Provider var session = Session(configuration: createSessionConfiguration())

        let sut = AlamofireAdapter()
        checkMemoryLeak(for: sut, file: file, line: line)
        
        return (sut, fakeURL())
    }
    
    private func createSessionConfiguration() -> URLSessionConfiguration{
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
//        configuration.timeoutIntervalForRequest = TimeInterval(0.1)
        
        return configuration
    }
}
