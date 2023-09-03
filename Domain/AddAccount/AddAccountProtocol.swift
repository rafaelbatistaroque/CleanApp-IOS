import Foundation

//MARK: - Add account
public protocol AddAccountProtocol{
    func handle(input: AddAccountInput) -> Result<AddAccountOutput, Error>
}
