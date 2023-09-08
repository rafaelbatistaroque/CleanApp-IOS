import UIKit
import Domain

final class SignUpViewController: UIViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!

    var signUp: ((AddAccountInput) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton?.layer.cornerRadius = 5
        configure()
    }

    private func configure(){
        saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc private func saveButtonTapped(){
        signUp?(AddAccountInput(
            name: nameTextField?.text ?? "",
            email: emailTextField?.text ?? "",
            password: passwordTextField?.text ?? "",
            passwordConfirmation: passwordConfirmationTextField?.text ?? ""))
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
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
}
