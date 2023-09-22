import SwiftUI
import Presenter
import Shared

struct WelcomeView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Image("logo")
                    .padding(.top, 40)

                TitleScreenView(titleName: "BEM-VINDO", color: .white)

                Spacer()

                VStack(spacing: 16){
                    //MARK: - Buttons
                    NavigationLink(destination: ViewsFactory.makeSignUpView){
                        TextAsButton(text: "CRIAR CONTA")}

                    CustomDivider(label: "ou")

                    NavigationLink(destination: ViewsFactory.makeLoginView){
                        TextAsButton(text: "ENTRAR")}

                }
                .padding(.horizontal, 32)
                Spacer()
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(CustomColor.primary)
        }
    }
}

struct CustomDivider: View{
    var label:String
    var body: some View {
        HStack{
            VStack{
                Divider()
                    .background(.white)
            }
            Text(label).foregroundStyle(.white)
            VStack{
                Divider()
                    .background(.white)
            }
        }
    }
}

struct TextAsButton: View {
    var text:String
    var body: some View {
        Text(text)
            .foregroundStyle(CustomColor.primary).font(.system(size: 16)).fontWeight(.bold)
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
            .padding(.vertical, 18)
            .padding(.horizontal)
            .background(.white)
            .cornerRadius(8)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
