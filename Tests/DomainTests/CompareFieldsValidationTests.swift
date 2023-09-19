import XCTest
import Domain

final class CompareFieldsValidationTests: XCTestCase {
    func test_givenCompareFieldsValidation_whenFailsComparation_thenReturnEspecificMessageError(){
        //arrange
        let sut = createSUT(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password")

        //act
        let result = sut.validate(data: ["password": "any_password", "passwordConfirmation": "any_passwordConfirmation"])

        //assert
        expect(should: result, beEqual: ["O campo Password é inválido"])
    }

    func test_givenCompareFieldsValidation_whenCorrectFieldLabelNotProvided_thenReturnEspecificMessageError(){
        //arrange
        let sut = createSUT(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")

        //act
        let result = sut.validate(data: ["password": "any_password", "passwordConfirmation": "any_passwordConfirmation"])

        //assert
        expect(should: result, beEqual: ["O campo Confirmar Senha é inválido"])
    }

    func test_givenCompareFieldsValidation_whenFieldNil_thenReturnMessageErrorWithCorrectFieldLabel(){
        //arrange
        let sut = createSUT(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password")

        //act
        let result = sut.validate(data: nil)

        //assert
        expect(should: result, beEqual: ["O campo Password é inválido"])
    }

    func test_givenCompareFieldsValidation_whenNoFails_thenReturnEmptyErrorList(){
        //arrange
        let sut = createSUT(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password")

        //act
        let result = sut.validate(data: ["password": "any_password", "passwordConfirmation": "any_password"])

        //assert
        expect(should: result, beEqual: [])
    }

    func test_givenCompareFieldsValidation_whenNotSameInstance_thenEnsureReturnFalse(){
        //arrange & act
        let instance1 = createSUT(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password")
        let instance2 = createSUT(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password")

        //assert
        expect(should: instance1, notBeEqual: instance2)
    }

    func test_givenCompareFieldsValidation_whenSameInstance_thenEnsureReturnTrue(){
        //arrange & act
        let instance1 = createSUT(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password")
        let sameInstance = instance1

        //assert
        expect(should: instance1, beEqual: sameInstance)
    }
}
