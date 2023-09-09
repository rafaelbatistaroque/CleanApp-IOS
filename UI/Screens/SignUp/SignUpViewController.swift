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
        if let errorMessage = validate(){
            alertView?.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: errorMessage))
        }
        signUp?(AddAccountInput(
            name: nameTextField?.text,
            email: emailTextField?.text,
            password: passwordTextField?.text,
            passwordConfirmation: passwordConfirmationTextField?.text))
    }

    private func validate() -> String?{
        if (isNullOrEmpty(field: nameTextField)) {
            return "O campo Nome é obrigatório"
        }
        if(isNullOrEmpty(field: emailTextField)){
            return "O campo Email é obrigatório"
        }
        if(isNullOrEmpty(field: passwordTextField)){
            return "O campo Senha é obrigatório"
        }
        if isNullOrEmpty(field: passwordConfirmationTextField){
            return "O campo Confirmar de Senha é obrigatório"
        }
        if isNotEquals(field: passwordTextField, anotherField: passwordConfirmationTextField) {
            return "Os campos Senha e Confirmar Senha não são iguais"
        }

        return nil
    }

    private func isNullOrEmpty(field:UITextField!) -> Bool{
        field.hasText == false || field.text?.isEmpty == true
    }

    private func isNotEquals(field:UITextField!, anotherField:UITextField!) -> Bool {
        passwordTextField != passwordConfirmationTextField
    }
}
