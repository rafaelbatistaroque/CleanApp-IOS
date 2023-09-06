import Foundation
import Application
import Alamofire

extension AlamofireAdapterTests {
    func createCaseTestsList(withExpectedConditions items:[(data: Data?, response: HTTPURLResponse?, error: Error?, expectedResult: Result<Data?, HttpError>)]) -> Array<(data: Data?, response: HTTPURLResponse?, error: Error?, expectedResult: Result<Data?, HttpError>)> {
        Array<(data: Data?, response: HTTPURLResponse?, error: Error?, expectedResult: Result<Data?, HttpError>)>(items)
    }
    
    func createSUT(file: StaticString = #filePath, line: UInt = #line) -> (AlamofireAdapter, URL){
        let sut = AlamofireAdapter(session: Session(configuration: createSessionConfiguration()))
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
