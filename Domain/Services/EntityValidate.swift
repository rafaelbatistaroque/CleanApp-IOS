import Foundation

class EntityValidate {
    private var value: String?
    private var message: String?
    private var errors:[String] = []
    var hasError:Bool {
        get { errors.isEmpty == false }
    }

    func getErrors() -> [String]{
        errors
    }

    func isNullOrEmpty(field:String?, message:String) -> EntityValidate {
        if field == nil || field?.isEmpty == true {
            errors.append(message)
        }

        return self
    }

    func isNotEquals(fieldOne:String?, fieldTwo:String?, message:String) -> EntityValidate {
        if fieldOne != fieldTwo{
            errors.append(message)
        }

        return self
    }
}
