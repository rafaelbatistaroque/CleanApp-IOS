import Foundation
import XCTest

extension XCTestCase {
    func expect<T:Equatable>(should value:T, beEqual expectedValue:T, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(value, expectedValue, file: file, line: line)
    }
    
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line){
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line:line)
        }
    }
}
