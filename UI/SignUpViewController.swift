import UIKit
import Domain

final class SignUpViewController: UIViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!

    var signUp: ((AddAccountInput) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure(){
        saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc private func saveButtonTapped(){
        signUp?(AddAccountInput(name: "nil", email: "nil", password: "nil", passwordConfirmation: "nil"))
    }
}

extension SignUpViewController: LoadingViewProtocol {
    func display(viewModel: LoadingViewModel) {
        viewModel.isLoading
        ? loadingIndicator?.startAnimating()
        : loadingIndicator?.stopAnimating()
    }
}

extension SignUpViewController: AlertViewProtocol {
    func showMessage(viewModel: AlertViewModel) {
        //TODO
    }
    
}
