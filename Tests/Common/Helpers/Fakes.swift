import Foundation
import Domain

func fakeInvalidData() -> Data{
    Data("invalid_data".utf8)
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

func fakeError() -> Error {
    NSError(domain: "any_error", code: 0)
}
