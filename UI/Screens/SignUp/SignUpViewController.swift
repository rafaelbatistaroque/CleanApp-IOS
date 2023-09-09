import UIKit
import Domain

final class SignUpViewController: UIViewController, Storyboarded {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!

    var signUp: ((AddAccountInput) -> Void)?
    var alertView: AlertViewProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure(){
        saveButton?.layer.cornerRadius = 5
        saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
    }

    @objc private func saveButtonTapped(){
        display(viewModel: LoadingViewModel(isLoading: true))
        if (nameTextField.hasText == false || nameTextField?.text?.isEmpty == true) {
            alertView?.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório"))
        }else if(emailTextField.hasText == false || emailTextField?.text?.isEmpty == true){
            alertView?.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatório"))
        }else if(passwordTextField.hasText == false || passwordTextField.text?.isEmpty == true){
            alertView?.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: "O campo Password é obrigatório"))
        }

        signUp?(AddAccountInput(
            name: nameTextField?.text ?? "",
            email: emailTextField?.text ?? "",
            password: passwordTextField?.text ?? "",
            passwordConfirmation: passwordConfirmationTextField?.text ?? ""))
    }
}
