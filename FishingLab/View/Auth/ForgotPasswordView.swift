import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var navigationManager : NavigationManager
    @State var emailController = ""
    
    func forgotPasswordAction() {
        
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.backgroundColor.ignoresSafeArea(.all)
            
            ScrollView {
                VStack {
                    Image("Lock-2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(.top, 150)
                    
                    Text("Forgot Password")
                        .h1() // Custom Text modifier
                        .padding(.bottom, 20)
                    
                    CustomTextFieldView(
                        text: $emailController,
                        placeholder: "Email"
                    )
                    .padding(.horizontal)
                    ExpandedButton(text: "Send", action: forgotPasswordAction)
                        .padding(.horizontal)
                    
                }
            }
            
            
            Button(action: {
                navigationManager.pop()
            }) {
                HStack {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .imageScale(.large)
                        .fontWeight(.bold)
                }
                .padding()
            }
            .padding(.leading, 10) // Отступ от левого края
            .padding(.top, 15) // Отступ от верхнего края
        }
    }
}

#Preview {
    ForgotPasswordView()
}
