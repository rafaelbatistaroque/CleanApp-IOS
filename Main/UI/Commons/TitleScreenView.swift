import SwiftUI
import Shared

struct TitleScreenView: View {
    @State var titleName:String
    @State var color:Color
    var body: some View {
        Text(titleName)
            .padding(.top, 24)
            .padding(.bottom, 16)
            .font(.system(size: 20))
            .fontWeight(.bold)
            .foregroundStyle(color)
    }
}
