import Foundation
import Presenter
import Domain

//MARK: - AddAccount
func fakeAddAccountViewModel(name:String? = "any_name", email:String? = "test@email.com", password:String? = "any_password", passwordConfirmation:String? = "any_password") -> AddAccountViewModel{
    AddAccountViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

func fakeAddAccountOutput() -> AddAccountOutput{
    AddAccountOutput(accessToken: UUID().uuidString)
}

func fakeAddAccountInput(name:String? = "any_name", email:String? = "test@email.com", password:String? = "any_password", passwordConfirmation:String? = "any_password") -> AddAccountInput{
    AddAccountInput(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

//MARK: - Authentication
func fakeAuthenticationViewModel(email:String? = "test@email.com", password:String? = "any_password") -> AuthenticationViewModel{
    AuthenticationViewModel(email: email, password: password)
}

func fakeAuthenticationInput(email:String? = "test@email.com", password:String? = "any_password") -> AuthenticationInput{
    AuthenticationInput(email: email, password: password)
}

func fakeAuthenticationOutput() -> AuthenticationOutput{
    AuthenticationOutput(accessToken: UUID().uuidString)
}
