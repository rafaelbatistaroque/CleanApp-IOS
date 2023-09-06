import Foundation
import XCTest

extension XCTestCase {
    func expect<T:Equatable>(should value:T, beEqual expectedValue:T, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(value, expectedValue, file: file, line: line)
    }
    
    func expect<T:Equatable>(should value:T, notBeEqual expectedValue:T, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertNotEqual(value, expectedValue, file: file, line: line)
    }
    
    func expect<T>(shouldNotBeNil expectedValue:T?, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertNotNil(expectedValue, file: file, line: line)
    }
    
    func expect<T>(shouldBeNil expectedResult:T?, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertNil(expectedResult, file: file, line: line)
    }
    
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line){
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line:line)
        }
    }
}
