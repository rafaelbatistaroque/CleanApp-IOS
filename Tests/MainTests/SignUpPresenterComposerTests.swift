import XCTest
import Main
import Domain

final class SignUpPresenterComposerTests: XCTestCase {

    func test_givenSignUpPresenterComposer_whenMakeValidations_thenEnsureCorrectsValidationsHasBeenCreated(){
        //arrange & act
        let (validationsSUT, expectedRequiredValidation, expectedEmailValidation, expectedCompareValidation, expectedTotalValidations) = createSUT();

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
                case let validationCompare as CompareFieldValidation:
                    expect(shouldBeTrue: expectedCompareValidation.contains(where: { item in
                        item.fieldName == validationCompare.fieldName && item.fieldNameToCompare == validationCompare.fieldNameToCompare && item.fieldLabel == validationCompare.fieldLabel }))
                default:
                    noExpect(item: validation)
            }
        }

    }

}
