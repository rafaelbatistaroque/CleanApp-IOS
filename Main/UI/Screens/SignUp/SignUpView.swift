import SwiftUI
import Presenter
import Shared

struct SignUpView: View {
    @StateObject var presenter: SignUpPresenter

    @State var name:String = ""
    @State var email:String = ""
    @State var password:String = ""
    @State var passwordConfirmation:String = ""
    

    var body: some View {
        NavigationStack {
            VStack {
                VStack{
                    Image("logo")
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: 180)
                .background(CustomColor.primary)

                Text("CADASTRO")
                    .padding(.top, 24)
                    .padding(.bottom, 16)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(CustomColor.primaryDark)

                VStack{
                    CustomTextField(prompt: "Name", binding: $name)
                    CustomTextField(prompt: "E-mail", binding: $email)

                    CustomSecureField(prompt: "Password", binding: $password)
                    CustomSecureField(prompt: "Password Confirmation", binding: $passwordConfirmation)

                    Button {

                        Task{
                            await presenter.signUp(
                                viewModel: AddAccountViewModel(
                                    name: name,
                                    email: email,
                                    password: password,
                                    passwordConfirmation: passwordConfirmation))
                        }
                    } label: {
                        Text("CRIAR CONTA")
                            .foregroundStyle(.white).font(.system(size: 16)).fontWeight(.bold)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .padding(.horizontal)
                            .background(CustomColor.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                            .padding(.top, 44)

                    }
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
            .background(.white)
            .onTapGesture {
//                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            }
            .alert(isPresented: $presenter.isShowAlert) {
                switch presenter.state {
                    case .success(let success):
                        Alert(title: Text("Success"), message: Text(success), dismissButton: .default(Text("Ok")))
                    default:
                        Alert(title: Text("Error"))
                }
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .navigationTitle("ForDev")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(CustomColor.primaryDark, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

struct CustomTextField: View {
    @State var prompt: String
    @Binding var binding: String

    var body: some View {
        TextField("", text: $binding, prompt: Text(prompt).foregroundColor(CustomColor.primaryLight))
            .padding(.all, 14)
            .foregroundColor(CustomColor.primaryLight)
            .background(.white)
            .cornerRadius(8.0)
            .keyboardType(.default)
            .disableAutocorrection(true)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(CustomColor.primaryLight, lineWidth: 1.5))
            .padding(.bottom, 8)
    }
}

struct CustomSecureField: View {
    @State var prompt: String
    @Binding var binding: String

    var body: some View {
        SecureField("", text: $binding, prompt: Text(prompt).foregroundColor(CustomColor.primaryLight))
            .padding(.all, 14)
            .foregroundColor(CustomColor.primaryLight)
            .background(.white)
            .foregroundColor(.black)
            .cornerRadius(8.0)
            .textContentType(.oneTimeCode)
            .disableAutocorrection(true)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(CustomColor.primaryLight, lineWidth: 1.5))
            .padding(.bottom, 8)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(presenter: SignUpPresenterFactory.factory())
    }
}
