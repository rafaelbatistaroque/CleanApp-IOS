import SwiftUI
import Shared

struct CustomSecureFieldView: View {
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
