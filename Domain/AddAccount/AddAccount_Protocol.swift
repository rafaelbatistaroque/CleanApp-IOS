import Foundation

//MARK: - Add account
protocol AddAccount_Protocol{
    func handle(input: AddAccountInput) -> Result<AddAccountOutput, Error>
}
