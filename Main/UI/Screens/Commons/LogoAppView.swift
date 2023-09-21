import SwiftUI
import Shared

struct LogoAppView: View {
    var body: some View {
        VStack{
            Image("logo")
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: 180)
        .background(CustomColor.primary)
    }
}
