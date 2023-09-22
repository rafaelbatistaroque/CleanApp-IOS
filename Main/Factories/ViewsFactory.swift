import Foundation
import SwiftUI

class ViewsFactory {

    static func makeLoginView() -> LoginView {
        LoginView(presenter: LoginPresenterComposer.factory())
    }

    static func makeSignUpView() -> SignUpView {
        SignUpView(presenter: SignUpPresenterComposer.factory())
    }
}
