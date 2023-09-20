import XCTest

final class AuthenticationViewModelTests: XCTestCase {
    func test_givenAuthenticationViewModel_whenNotSameInstance_thenEnsureReturnFalse(){
        //arrange & act
        let instance1 = fakeAuthenticationViewModel()
        let instance2 = fakeAuthenticationViewModel()

        //assert
        expect(should: instance1, notBeEqual: instance2)
    }

    func test_givenAuthenticationViewModel_whenSameInstance_thenEnsureReturnTrue(){
        //arrange & act
        let instance1 = fakeAuthenticationViewModel()
        let sameInstance = instance1

        //assert
        expect(should: instance1, beEqual: sameInstance)
    }

    func test_givenAuthenticationViewModel_whenToAuthenticationInput_thenEnsureReturnAuthenticationInputWithCorrectData(){
        //arrange
        let authenticationViewModel = fakeAuthenticationViewModel()

        //act
        let result = authenticationViewModel.toAuthenticationInput()

        //assert
        expect(should: result.email, beEqual: authenticationViewModel.email)
        expect(should: result.password, beEqual: authenticationViewModel.password)
    }

}
