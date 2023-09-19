import Foundation
import Domain

class SignUpPresenterValidateSpy: ValidateProtocol {
    var data:[String: Any]?
    var result:[String] = []

    func validate(data: [String : Any]?) -> [String] {
        self.data = data

        return self.result
    }

    func simulateError(){
        self.result = ["Erro"]
    }
}
