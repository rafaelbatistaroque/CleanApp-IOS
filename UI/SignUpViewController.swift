import UIKit

final class SignUpViewController: UIViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SignUpViewController: LoadingViewProtocol {
    func display(viewModel: LoadingViewModel) {
        viewModel.isLoading
        ? loadingIndicator?.startAnimating()
        : loadingIndicator?.stopAnimating()
    }
}
