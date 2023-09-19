import XCTest
import Domain

final class RequiredFieldValidationTests: XCTestCase {
    func test_givenRequiredFieldValidation_whenFieldNotProvided_thenReturnEspecificMessageError(){
        //arrange
        let sut = createSUT(fieldName: "email", fieldLabel: "E-mail")

        //act
        let result = sut.validate(data: ["name": "any_name"])

        //assert
        expect(should: result, beEqual: ["O campo E-mail é obrigatório"])
    }

    func test_givenRequiredFieldValidation_whenFieldNotProvided_thenReturnMessageErrorWithCorrectFieldLabel(){
        //arrange
        let sut = createSUT(fieldName: "password", fieldLabel: "Password")

        //act
        let result = sut.validate(data: ["name": "any_name"])

        //assert
        expect(should: result, beEqual: ["O campo Password é obrigatório"])
    }

    func test_givenRequiredFieldValidation_whenFieldNil_thenReturnMessageErrorWithCorrectFieldLabel(){
        //arrange
        let sut = createSUT(fieldName: "password", fieldLabel: "Password")

        //act
        let result = sut.validate(data: nil)

        //assert
        expect(should: result, beEqual: ["O campo Password é obrigatório"])
    }

    func test_givenRequiredFieldValidation_whenNoFails_thenReturnEmptyErrorList(){
        //arrange
        let sut = createSUT(fieldName: "age", fieldLabel: "Age")

        //act
        let result = sut.validate(data: ["age": "any_age"])

        //assert
        expect(should: result, beEqual: [])
    }

    func test_givenCompareFieldsValidation_whenNotSameInstance_thenEnsureReturnFalse(){
        //arrange & act
        let instance1 = createSUT(fieldName: "age", fieldLabel: "Age")
        let instance2 = createSUT(fieldName: "age", fieldLabel: "Age")

        //assert
        expect(should: instance1, notBeEqual: instance2)
    }

    func test_givenCompareFieldsValidation_whenSameInstance_thenEnsureReturnTrue(){
        //arrange & act
        let instance1 = createSUT(fieldName: "age", fieldLabel: "Age")
        let sameInstance = instance1

        //assert
        expect(should: instance1, beEqual: sameInstance)
    }
}
