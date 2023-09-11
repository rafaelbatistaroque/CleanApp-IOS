import Foundation
import Domain
import Presenter

func fakeInvalidData() -> Data{
    Data("invalid_data".utf8)
}

func fakeEmptyData() -> Data {
    Data()
}

func fakeValidData() -> Data{
    Data("{\"name\":\"Rafael\"}".utf8)
}

func fakeURL() -> URL{
    URL(string: "https://any_url.com")!
}

func fakeAddAccountOutput() -> AddAccountOutput{
    AddAccountOutput(id: "any_id", name: "any_name", email: "any_email", password: "any_password")
}

func fakeAddAccountViewModel(name:String? = "any_name", email:String? = "any_email", password:String? = "any_password", passwordConfirmation:String? = "any_password") -> AddAccountViewModel{
    AddAccountViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

func fakeAddAccountInput(name:String? = "any_name", email:String? = "any_email", password:String? = "any_password", passwordConfirmation:String? = "any_password") -> AddAccountInput{
    AddAccountInput(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

func fakeAccountInputError(name:String? = "any_name", email:String? = "any_email", password:String? = "any_password", passwordConfirmation:String? = "any_password") -> DomainError {
    var errorMessage:[String] = []
    if name == nil {
        errorMessage.append(AddAccountInputErrorMessage.requiredName.rawValue)
    }
    if email == nil {
        errorMessage.append(AddAccountInputErrorMessage.requiredEmail.rawValue)
    }
    if password == nil {
        errorMessage.append(AddAccountInputErrorMessage.requiredPassword.rawValue)
    }
    if passwordConfirmation == nil {
        errorMessage.append(AddAccountInputErrorMessage.requiredPasswordConfirmation.rawValue)
    }
    if password != passwordConfirmation {
        errorMessage.append(AddAccountInputErrorMessage.failPasswordConfirmation.rawValue)
    }

    return .validate(withMessage: errorMessage)
}

func fakeError() -> Error {
    NSError(domain: "any_error", code: 0)
}

func fakeUrlResponse(statusCode:Int = 200) -> HTTPURLResponse{
    HTTPURLResponse(url: fakeURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
