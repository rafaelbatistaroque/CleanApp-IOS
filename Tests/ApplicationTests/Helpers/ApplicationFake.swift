import Foundation
import Domain

//MARK: - AddAccount
func fakeAddAccountOutput() -> AddAccountOutput{
    AddAccountOutput(accessToken: UUID().uuidString)
}

func fakeAddAccountInput(name:String? = "any_name", email:String? = "test@email.com", password:String? = "any_password", passwordConfirmation:String? = "any_password") -> AddAccountInput{
    AddAccountInput(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

func fakeAddAccountInputValid() -> AddAccountInput{
    AddAccountInput(name: "any_name", email: "test@email.com", password: "any_password", passwordConfirmation: "any_password")
}

func fakeAddAccountInputInvalidWith(name:String? = "any_name", email:String? = "test@email.com", password:String? = "any_password", passwordConfirmation:String? = "any_password") -> AddAccountInput{
    AddAccountInput(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}
//MARK: - Authentication
func fakeAuthenticationInputValid() -> AuthenticationInput{
    AuthenticationInput(email: "test@email.com", password: "any_password")
}

func fakeAuthenticationInputInvalidWith(email:String? = "test@email.com", password:String? = "any_password") -> AuthenticationInput{
    AuthenticationInput(email: email, password: password)
}

func fakeAuthenticationOutput() -> AuthenticationOutput {
    AuthenticationOutput(accessToken: UUID().uuidString)
}
