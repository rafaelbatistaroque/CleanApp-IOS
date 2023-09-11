import Foundation
import Presenter
import Shared

class AlertViewSpy: AlertViewProtocol{
    var viewModel: AlertViewModel? = nil
    func showMessage(viewModel: AlertViewModel) {
        self.viewModel = viewModel
    }
}

extension WeakVarProxy:AlertViewProtocol where T: AlertViewProtocol{
    public func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}
