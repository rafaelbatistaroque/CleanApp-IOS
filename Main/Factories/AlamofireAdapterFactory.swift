import Foundation
import Alamofire
import Shared
import Infra

class AlamofireAdapterFactory {
    static func factory() -> AlamofireAdapter {
        @Provider var sessionProvided = Session()
        return AlamofireAdapter()
    }
}
