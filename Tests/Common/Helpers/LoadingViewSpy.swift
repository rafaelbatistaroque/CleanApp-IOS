import Foundation
import Presenter
import Shared

class LoadingViewSpy: LoadingViewProtocol {
    var isLoading: Bool = false
    var isInicialLoading: Bool = false
    var isEndLoading: Bool = false

    func display(viewModel: LoadingViewModel) {
        if self.isInicialLoading && viewModel.isLoading {
            self.isLoading = true
        }
        else if self.isEndLoading && viewModel.isLoading == false {
            self.isLoading = false
        }
    }

    func inicialLoading(){
        self.isInicialLoading = true
    }

    func endLoading(){
        self.isEndLoading = true
    }
}

extension WeakVarProxy:LoadingViewProtocol where T: LoadingViewProtocol{
    public func display(viewModel: Presenter.LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}
