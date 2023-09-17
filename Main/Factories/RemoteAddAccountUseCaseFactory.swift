import Foundation
import Application
import Shared

class RemoteAddAccountUseCaseFactory{
    static func factory() -> RemoteAddAccountUseCase {
        @Provider var alamofireAdapterProvided = AlamofireAdapterFactory.factory() as HttpPostClientProtocol

        return  RemoteAddAccountUseCase(url: URL(string: "https://clean-node-api.herokuapp.com/api/signup")!)
    }
}
