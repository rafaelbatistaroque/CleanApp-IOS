import SwiftUI
import Presenter
import Shared

struct SignUpView: View {
    @StateObject var presenter: SignUpPresenter

    @State var name:String = ""
    @State var email:String = ""
    @State var password:String = ""
    @State var passwordConfirmation:String = ""
    @State var isDisabledControl:Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                LogoApp()
                TitleScreen()

                VStack(spacing: 16){

                    //MARK: - Fields
                    CustomTextField(prompt: "Name", bindingContent: $name, bindingIsDisabledControl: $isDisabledControl)
                        .keyboardType(.default)
                    CustomTextField(prompt: "E-mail", bindingContent: $email, bindingIsDisabledControl: $isDisabledControl)
                        .keyboardType(.emailAddress)

                    CustomSecureField(prompt: "Password", bindingContent: $password, bindingIsDisabledControl: $isDisabledControl)
                    CustomSecureField(prompt: "Password Confirmation", bindingContent: $passwordConfirmation, bindingIsDisabledControl: $isDisabledControl)

                    //MARK: - Button criate account
                    Button("CRIAR CONTA"){
                        self.isDisabledControl = true
                        signUp()
                    }
                    .foregroundStyle(.white).font(.system(size: 16)).fontWeight(.bold)
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .padding(.horizontal)
                    .background(self.isDisabledControl ? .gray : CustomColor.primary)
                    .cornerRadius(8)
                    .disabled(self.isDisabledControl)

                    //MARK: - progressView
                    if case .loading = presenter.state {
                        ProgressView()
                            .tint(CustomColor.primaryLight)
                            .controlSize(.large)
                            .padding(.vertical, 16)
                    }

                }
                .padding(.horizontal, 32)
                Spacer()

            }
            .onTapGesture {
                hideKeyBoard()
            }
            //MARK: - Alerts
            .alert(isPresented: $presenter.isShowAlert) {
                switch presenter.state {
                    case .success(let alert,_):
                        Alert(title: Text(alert.title), message: Text(alert.message),
                              dismissButton: .default(Text("Ok"), action: { clearFields(); enableControls() }))
                    case .failure(let error):
                        Alert(title: Text(error.title), message: Text("\(error.message)"),
                              primaryButton: .default(Text("Ok"), action: { enableControls() }),
                              secondaryButton: .destructive(Text("Clear Fields"), action: { enableControls(); clearFields() }))
                    default:
                        Alert(title: Text("Erro"), message: Text("Algo inesperado aconteceu. Tente novamente mais tarde."),
                              dismissButton: .default(Text("Ok"), action: {clearFields(); enableControls()}) )
                }
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(.white)
            .navigationTitle("ForDev")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(CustomColor.primaryDark, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }

    func enableControls(){
        self.isDisabledControl = false
    }

    func hideKeyBoard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func signUp(){
        Task{
            await presenter.signUp(
                viewModel: AddAccountViewModel(
                    name: name,
                    email: email,
                    password: password,
                    passwordConfirmation: passwordConfirmation))
        }
    }

    func clearFields(){
        self.name = ""
        self.email = ""
        self.password = ""
        self.passwordConfirmation = ""
    }
}

struct CustomTextField: View {
    @State var prompt: String
    @Binding var bindingContent: String
    @Binding var bindingIsDisabledControl: Bool

    var body: some View {
        TextField("", text: $bindingContent, prompt: Text(prompt)
            .foregroundColor(bindingIsDisabledControl ? .gray : CustomColor.primaryLight))
        .foregroundColor(CustomColor.primaryLight)
        .padding(.all, 14)
        .background(.white)
        .disableAutocorrection(true)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(bindingIsDisabledControl ? .gray : CustomColor.primaryLight, lineWidth: 1.5))
        .disabled(bindingIsDisabledControl)
    }
}

struct CustomSecureField: View {
    @State var prompt: String
    @Binding var bindingContent: String
    @Binding var bindingIsDisabledControl: Bool

    var body: some View {
        SecureField("", text: $bindingContent, prompt: Text(prompt)
            .foregroundColor(bindingIsDisabledControl ? .gray : CustomColor.primaryLight))
        .foregroundColor(CustomColor.primaryLight)
        .padding(.all, 14)
        .background(.white)
        .foregroundColor(.black)
        .textContentType(.oneTimeCode)
        .disableAutocorrection(true)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(bindingIsDisabledControl ? .gray : CustomColor.primaryLight, lineWidth: 1.5))
        .disabled(bindingIsDisabledControl)
    }
}

struct LogoApp: View {
    var body: some View {
        VStack{
            Image("logo")
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: 180)
        .background(CustomColor.primary)
    }
}

struct TitleScreen: View {
    var body: some View {
        Text("CADASTRO")
            .padding(.top, 24)
            .padding(.bottom, 16)
            .font(.system(size: 20))
            .fontWeight(.bold)
            .foregroundStyle(CustomColor.primaryDark)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(presenter: SignUpPresenterComposer.factory())
    }
}
