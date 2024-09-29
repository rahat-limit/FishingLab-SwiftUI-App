//
//  NavigationControllerView.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 19.09.2024.
//

import SwiftUI

struct NavigationControllerView: View {
    @EnvironmentObject var navigationManager : NavigationManager
    @EnvironmentObject var appLoadingManager : AppLoadingManager
    @EnvironmentObject var errorManager : ErrorManager
    var body: some View {
        NavigationStack {
            ZStack {
                Group {
                    switch navigationManager.currentScreen {
                    case .signIn:
                        SignInView().trackError(using: errorManager)
                    case .signUp:
                        SignUpView()
                            .trackError(using: errorManager)
                    case .onboarding:
                        OnBoardingView()
                            .trackError(using: errorManager)
                    case .forgotPassword:
                        ForgotPasswordView()
                            .trackError(using: errorManager)
                    case .tabView:
                        TabsView()
                            .trackError(using: errorManager)
                    case .empty:
                        EmptyView()
                            .trackError(using: errorManager)
                    }
                
                }
                if appLoadingManager.loading {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    VStack {
                        ProgressView("Loading...") // Прогресс-бар
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationControllerView()
}
