import XCTest

final class AddAccountViewModelTests: XCTestCase {
    func test_givenAddAccountViewModel_whenNotSameInstance_thenEnsureReturnFalse(){
        //arrange & act
        let instance1 = fakeAddAccountViewModel()
        let instance2 = fakeAddAccountViewModel()

        //assert
        expect(should: instance1, notBeEqual: instance2)
    }

    func test_givenAddAccountViewModel_whenSameInstance_thenEnsureReturnTrue(){
        //arrange & act
        let instance1 = fakeAddAccountViewModel()
        let sameInstance = instance1

        //assert
        expect(should: instance1, beEqual: sameInstance)
    }

    func test_givenAddAccountViewModel_whenToAddAccountInput_thenEnsureReturnAddAccountInputWithCorrectData(){
        //arrange
        let addAccountViewModel = fakeAddAccountViewModel()

        //act
        let result = addAccountViewModel.toAddAccountInput()

        //assert
        expect(should: result.name, beEqual: addAccountViewModel.name)
        expect(should: result.email, beEqual: addAccountViewModel.email)
        expect(should: result.password, beEqual: addAccountViewModel.password)
        expect(should: result.passwordConfirmation, beEqual: addAccountViewModel.passwordConfirmation)
    }
}
