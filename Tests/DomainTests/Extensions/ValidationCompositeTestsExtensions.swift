import Foundation
import Domain

extension ValidationCompositeTests{
    func createSUT(validations: [ValidationSpy], file: StaticString = #filePath, line: UInt = #line) -> ValidationComposite {

        let sut = ValidationComposite(validations: validations)

        checkMemoryLeak(for: sut, file: file,line: line)
        for validation in validations{
            checkMemoryLeak(for: validation, file: file,line: line)
        }

        return sut
    }
}
