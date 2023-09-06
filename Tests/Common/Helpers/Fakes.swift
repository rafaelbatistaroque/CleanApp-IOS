import Foundation
import Domain

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

func fakeError() -> Error {
    NSError(domain: "any_error", code: 0)
}

func fakeUrlResponse(statusCode:Int = 200) -> HTTPURLResponse{
    HTTPURLResponse(url: fakeURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
