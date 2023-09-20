import Foundation
import Application
import Infra
import Shared
import Alamofire

extension UseCasesIntegrationTests {
    func createSUT() -> RemoteAddAccountUseCase {
        @Provider var alamofireProvided = Session()
        @Provider var adapterProvided = AlamofireAdapter() as HttpPostClientProtocol

        let sut = RemoteAddAccountUseCase(url: URL(string: "https://fordevs.herokuapp.com/api/signup")!)

        return sut
    }
}
