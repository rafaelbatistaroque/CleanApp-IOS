import SwiftUI
import Presenter
import Shared

struct LoginView: View {
    @StateObject var presenter: LoginPresenter
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var email:String = ""
    @State var password:String = ""
    @State var isDisabledControl:Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                HeaderView()
                TitleScreenView(titleName: "LOGIN", color: CustomColor.primaryDark)

                VStack(spacing: 16){

                    //MARK: - Fields
                    CustomTextFieldView(prompt: "E-mail", bindingContent: $email, bindingIsDisabledControl: $isDisabledControl)
                        .keyboardType(.emailAddress)

                    CustomSecureFieldView(prompt: "Password", bindingContent: $password, bindingIsDisabledControl: $isDisabledControl)

                    //MARK: - Button criate account
                    Button("ENTRAR"){
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
                    case .success(let alertSuccess, _):
                        Alert(title: Text(alertSuccess.title), message: Text(alertSuccess.message),
                              dismissButton: .default(Text("Ok"), action: { clearFields(); enableControls() }))
                    case .failure(let alertError, _):
                        Alert(title: Text(alertError.title), message: Text("\(alertError.message)"),
                              primaryButton: .default(Text("Ok"), action: { enableControls() }),
                              secondaryButton: .destructive(Text("Clear Fields"), action: { enableControls(); clearFields() }))
                    default:
                        Alert(title: Text("Erro"), message: Text("Algo inesperado aconteceu. Tente novamente mais tarde."),
                              dismissButton: .default(Text("Ok"), action: {clearFields(); enableControls()}) )
                }
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(.white)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: Image(systemName: "chevron.backward")
                .foregroundColor(.white).fontWeight(.semibold)
                .padding(.vertical, 16)
                .padding(.trailing, 28)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
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
            await presenter.login(
                viewModel: AuthenticationViewModel(
                    email: email,
                    password: password))
        }
    }

    func clearFields(){
        self.email = ""
        self.password = ""
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(presenter: LoginPresenterComposer.factory())
    }
}
