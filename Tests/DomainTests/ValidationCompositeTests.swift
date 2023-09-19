import XCTest
import Domain

final class ValidationCompositeTests: XCTestCase {
    func test_givenValidationComposite_whenFailValidate_thenReturnErrorsList(){
        //arrange
        let validationSpy = ValidationSpy()
        validationSpy.simulateError(withMessage: "Any_Error")
        let sut = createSUT(validations: [validationSpy])

        //act
        let result = sut.validate(data: ["name":"any_name"])

        //assert
        expect(should: result, beEqual: ["Any_Error"])
    }

    func test_givenValidationComposite_whenFailValidate_thenReturnCorrectErrorsMessages(){
        //arrange
        let validationSpy2 = ValidationSpy()
        validationSpy2.simulateError(withMessage: "Another_Error")
        let sut = createSUT(validations: [ValidationSpy(), validationSpy2])

        //act
        let result = sut.validate(data: ["name":"any_name"])

        //assert
        expect(should: result, beEqual: ["Another_Error"])
    }

    func test_givenValidationComposite_whenMultiplesFailValidate_thenReturnCorrectErrorsMessages(){
        //arrange
        let validationSpy = ValidationSpy()
        let validationSpy2 = ValidationSpy()
        validationSpy.simulateError(withMessage: "Any_Error")
        validationSpy2.simulateError(withMessage: "Another_Error")
        let sut = createSUT(validations: [validationSpy, validationSpy2])

        //act
        let result = sut.validate(data: ["name":"any_name"])

        //assert
        expect(should: result, beEqual: ["Any_Error", "Another_Error"])
    }

    func test_givenValidationComposite_whenCallsValidate_thenEnsureWithCorrectData(){
        //arrange
        let validationSpy = ValidationSpy()
        let sut = createSUT(validations: [validationSpy])
        let expectedCallsData = ["name":"any_name"]

        //act
        _ = sut.validate(data: expectedCallsData)

        //assert
        expect(shouldBeTrue: NSDictionary(dictionary: validationSpy.data!).isEqual(to: expectedCallsData))
    }

    func test_givenValidationComposite_whenSuccessValidate_thenReturnEmptyErrorList(){
        //arrange
        let sut = createSUT(validations: [ValidationSpy(), ValidationSpy()])

        //act
        let result = sut.validate(data: ["name":"any_name"])

        //assert
        expect(should: result, beEqual: [])
    }

    func test_givenValidationComposite_whenNotSameInstance_thenEnsureReturnFalse(){
        //arrange & act
        let instance1 = createSUT(validations: [ValidationSpy()])
        let instance2 = createSUT(validations: [ValidationSpy()])

        //assert
        expect(should: instance1, notBeEqual: instance2)
    }

    func test_givenValidationComposite_whenSameInstance_thenEnsureReturnTrue(){
        //arrange & act
        let instance1 = createSUT(validations: [ValidationSpy()])
        let sameInstance = instance1

        //assert
        expect(should: instance1, beEqual: sameInstance)
    }
}
