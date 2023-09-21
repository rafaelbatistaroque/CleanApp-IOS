import Foundation
import Infra
import Alamofire
import Application
import Shared

class UseCasesFactory {
    static var apiBaseUrl: String = EnvironmentHelper.variable(.apiBaseUrl)
    static var httpClient: Session = Session()
    static var httpClientAdapter = AlamofireAdapter()

    private static func makeUrl(path:String) -> URL{
        URL(string: "\(apiBaseUrl)/\(path)")!
    }

    static func remoteAddAccountfactory() -> RemoteAddAccountUseCase {
        @Provider var httpClientProvided = httpClient
        @Provider var alamofireAdapterProvided = httpClientAdapter as HttpPostClientProtocol

        return  RemoteAddAccountUseCase(url: makeUrl(path: "signup"))
    }

    static func remoteAutenticationfactory() -> RemoteAuthenticationUseCase {
        @Provider var httpClientProvided = httpClient
        @Provider var alamofireAdapterProvided = httpClientAdapter as HttpPostClientProtocol

        return  RemoteAuthenticationUseCase(url: makeUrl(path: "login"))
    }
}
