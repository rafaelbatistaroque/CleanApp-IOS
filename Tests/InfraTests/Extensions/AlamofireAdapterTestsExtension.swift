import Foundation
import Alamofire

extension AlamofireAdapterTests {
    func createSUT(file: StaticString = #filePath, line: UInt = #line) -> (AlamofireAdapter, URL){
        let sut = AlamofireAdapter(session: Session(configuration: createSessionConfiguration()))
        checkMemoryLeak(for: sut, file: file, line: line)
        
        return (sut, fakeURL())
    }
    
    private func createSessionConfiguration() -> URLSessionConfiguration{
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        configuration.timeoutIntervalForRequest = TimeInterval(0.1)
        
        return configuration
    }
}
