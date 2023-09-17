import SwiftUI

@main
struct MainApp: App {
    init(){
        UINavigationBar.appearance().barTintColor = .white
    }

    var body: some Scene {
        WindowGroup {
            SignUpView(presenter: SignUpPresenterFactory.factory())
        }
    }
}
