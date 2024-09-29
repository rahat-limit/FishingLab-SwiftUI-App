//
//  SignInView.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 19.09.2024.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var navigationManager : NavigationManager
    @EnvironmentObject var authViewModel : AuthViewModelImpl
    @State var emailController = ""
    @State var passwordController = ""
    @State var forgotPasswordNavigated = false
    @State var redirectToSignUpScreen = false
    
    func signIn() async {
        guard ValidationHelper().isValid(values: [emailController, passwordController]) else {return}
        await authViewModel.signIn(email: emailController, password: passwordController)
    }
    
    func signInViaGoogle() async {
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
                            .padding(.top, 60)
                        Text("Sign In").h1()
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
                        forgotPasswordLink
                        ExpandedButton(action: {
                            Task {
                                await signIn()
                            }
                        })
                            .padding(.horizontal)
                        OrDivider()
                        GoogleButton(action: {
                            Task {
                                await signInViaGoogle()
                            }
                        })
                        AuthRedirectLink(action: {
                            navigationManager.navigateTo(from: Screen.signIn, to: Screen.signUp)
                        })
                    }
                }
            }
            
        }
        
    }
    var forgotPasswordLink: some View {
        Button(action: {
            navigationManager.navigateTo(from: Screen.signIn, to: Screen.forgotPassword)
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
    SignInView()
}
