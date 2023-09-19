import SwiftUI

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            SignUpView(presenter: SignUpPresenterComposer.factory())
        }
    }
}
