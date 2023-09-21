import XCTest
import Main
import Domain

final class LoginPresenterComposerTests: XCTestCase {

    func test_givenLoginPresenterComposer_whenMakeValidations_thenEnsureCorrectsValidationsHasBeenCreated(){
        //arrange & act
        let (validationsSUT, expectedRequiredValidation, expectedEmailValidation, expectedTotalValidations) = createSUT();

        //assert
        expect(should: validationsSUT.count, beEqual: expectedTotalValidations)
        for validation in validationsSUT {
            switch validation {
                case let requiredValidation as RequiredFieldValidation:
                    expect(shouldBeTrue: expectedRequiredValidation.contains(where: { item in
                        item.fieldName == requiredValidation.fieldName && item.fieldLabel ==  requiredValidation.fieldLabel }))
                case let validationEmail as EmailValidation:
                    expect(shouldBeTrue: expectedEmailValidation.contains(where: { item in
                        item.fieldName == validationEmail.fieldName && item.fieldLabel == validationEmail.fieldLabel }))
                default:
                    noExpect(to: validation)
            }
        }

    }

}
