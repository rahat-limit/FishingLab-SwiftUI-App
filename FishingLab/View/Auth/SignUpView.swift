//
//  SignUpView.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 19.09.2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var navigationManager : NavigationManager
    @EnvironmentObject var authViewModel : AuthViewModelImpl
    @State var emailController = ""
    @State var passwordController = ""
    @State var confirmPasswordController = ""
    @State var forgotPasswordNavigated = false
    @Environment(\.dismiss) var dismiss
    
    func signUp() async {
        guard ValidationHelper().isValid(values: [emailController, passwordController, confirmPasswordController]) && passwordController == confirmPasswordController else {return}
        await authViewModel.signUp(email: emailController, password: passwordController)
    }
    
    func signUpViaGoogle() async {
        await authViewModel.signByGoogleOAuth(pageFrom: .signIn)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        Image("Lock-2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .padding(.top, 25)
                        Text("Sign Up").h1()
                        CustomTextFieldView(
                            text: $emailController,
                            placeholder: "Email"
                        )
                        .padding(.horizontal)
                        CustomTextFieldView(
                            text: $passwordController,
                            placeholder: "Password"
                        )
                        .padding(.horizontal)
                        CustomTextFieldView(
                            text: $confirmPasswordController,
                            placeholder: "Confirm Password"
                        )
                        .padding(.horizontal)
                        forgotPasswordLink
                        ExpandedButton(text: "Sign Up",action:  {
                            Task {
                                await signUp()
                            }
                        })
                        .padding(.horizontal)
                        OrDivider()
                        GoogleButton(action: {
                            Task {
                                await signUpViaGoogle()
                            }
                        })
                        AuthRedirectLink(text: "Sign In",action: {
                            navigationManager.navigateTo(from: Screen.signUp, to: Screen.signIn)
                        })
                    }
                }
            }
            
        }
        
    }
    
    var forgotPasswordLink: some View {
        Button(action: {
            navigationManager.navigateTo(from: Screen.signUp, to: Screen.forgotPassword)
        }, label: {
            HStack {
                Spacer()
                Text("Forgot Password?")
                    .h4()
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        })
    }
}



#Preview {
    SignUpView()
}
