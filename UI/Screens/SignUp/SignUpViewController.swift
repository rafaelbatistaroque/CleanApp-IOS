import UIKit
import Presenter
import Domain
import Shared

final class SignUpViewController: UIViewController, Storyboarded {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!

    @Inject var presenter: SignUpPresenterProtocol

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure(){
        saveButton?.layer.cornerRadius = 5
        saveButton?.addTarget(self, action: #selector(self.saveButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
    }

    @objc func saveButtonTapped() {
        Task{
            await presenter.signUp(viewModel: AddAccountViewModel(
                name: nameTextField?.text,
                email: emailTextField?.text,
                password: passwordTextField?.text,
                passwordConfirmation: passwordConfirmationTextField?.text))
        }
    }
}
