import XCTest
import Domain

final class EmailValidationTests: XCTestCase {
    func test_givenEmailValidation_whenInvalidEmail_thenReturnEspecificMessageError(){
        //arrange
        let sut = createSUT(fieldName: "email", fieldLabel: "E-mail")

        //act
        let result = sut.validate(data: ["email": "invalid_email"])

        //assert
        expect(should: result, beEqual: ["O campo E-mail é inválido"])
    }

    func test_givenEmailValidation_whenFieldLabelNotProvided_thenReturnEspecificMessageError(){
        //arrange
        let sut = createSUT(fieldName: "email", fieldLabel: "E-mail de Trabalho")

        //act
        let result = sut.validate(data: ["email": "invalid_email"])

        //assert
        expect(should: result, beEqual: ["O campo E-mail de Trabalho é inválido"])
    }

    func test_givenEmailValidation_whenFieldNil_thenReturnEspecificMessageError(){
        //arrange
        let sut = createSUT(fieldName: "email", fieldLabel: "E-mail")

        //act
        let result = sut.validate(data: nil)

        //assert
        expect(should: result, beEqual: ["O campo E-mail é inválido"])
    }

    func test_givenEmailValidation_whenValidEmailProvided_tthenReturnEmptyErrorList(){
        //arrange
        let sut = createSUT(fieldName: "email", fieldLabel: "E-mail")

        //act
        let result = sut.validate(data: ["email": "email@teste.com"])

        //assert
        expect(should: result, beEqual: [])
    }

    func test_givenEmailValidation_whenNotSameInstance_thenEnsureReturnFalse(){
        //arrange & act
        let instance1 = createSUT(fieldName: "email", fieldLabel: "E-mail")
        let instance2 = createSUT(fieldName: "email", fieldLabel: "E-mail")

        //assert
        expect(should: instance1, notBeEqual: instance2)
    }

    func test_givenEmailValidation_whenSameInstance_thenEnsureReturnTrue(){
        //arrange & act
        let instance1 = createSUT(fieldName: "email", fieldLabel: "E-mail")
        let sameInstance = instance1

        //assert
        expect(should: instance1, beEqual: sameInstance)
    }
}
