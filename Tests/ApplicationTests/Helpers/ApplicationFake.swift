import Foundation
import Domain

func fakeAddAccountOutput() -> AddAccountOutput{
    AddAccountOutput(accessToken: UUID().uuidString)
}

func fakeAddAccountInput(name:String? = "any_name", email:String? = "test@email.com", password:String? = "any_password", passwordConfirmation:String? = "any_password") -> AddAccountInput{
    AddAccountInput(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}
