import Foundation
import Domain

final class ValidationSpy: ValidateProtocol{
    private var errors:[String] = []
    var data: [String : Any]? = nil

    func validate(data: [String : Any]?) -> [String] {
        self.data = data
        return self.errors
    }

    func simulateError(withMessage message:String = "Any_Error"){
        self.errors.append(message)
    }
}
