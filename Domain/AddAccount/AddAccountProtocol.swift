import Foundation

//MARK: - Add account
protocol AddAccountProtocol{
    func handle(input: AddAccountInput) -> Result<AddAccountOutput, Error>
}
