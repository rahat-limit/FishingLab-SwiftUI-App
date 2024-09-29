//
//  AuthViewModel.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 20.09.2024.
//

import Foundation
import FirebaseAuth
import UIKit

protocol AuthViewModel {
    func signIn(email: String, password: String) async
    func signUp(email: String, password: String) async
    func signOut(from prevScreen: Screen) async
    func getAuthenticatedUser() async -> User?
    func loadAuthenticatedUser() async
    func changePhoto(image: UIImage?) async
    func signByGoogleOAuth(pageFrom prevScreen : Screen) async
}

@MainActor
final class AuthViewModelImpl: ObservableObject, AuthViewModel {
    let authManager = AuthManagerImpl()
    let errorManager: ErrorManager
    let appLoadingManager: AppLoadingManager
    let navigationManager: NavigationManager
    let userDefaultStorageManager: UserDefaultStorageManager
    private(set) var myUser: User?
    @Published private(set) var userAvatar: String?
    
    init(errorManager: ErrorManager, appLoadingManager: AppLoadingManager, navigationManager: NavigationManager, userDefaultStorageManager: UserDefaultStorageManager) {
        self.errorManager = errorManager
        self.appLoadingManager = appLoadingManager
        self.navigationManager = navigationManager
        self.userDefaultStorageManager = userDefaultStorageManager
        Task {
            await loadAuthenticatedUser()
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            appLoadingManager.startLoading()
            try await authManager.signInUser(email: email, password: password) { result in
                switch result {
                case .failure(.failure(let message)):
                    self.errorManager.showError(message)
                case .success(.success(let user)):
                    self.myUser = user
                    self.navigationManager.navigateTo(from: .signIn, to: .tabView)
                    
                }
            }
            appLoadingManager.stopLoading()
            
        } catch {
            appLoadingManager.stopLoading()
            self.errorManager.showError(error.localizedDescription)
        }
    }
    
    func signUp(email: String, password: String) async {
        do {
            appLoadingManager.startLoading()
            try await authManager.signUpUser(email: email, password: password) { result in
                switch result {
                case .failure(.failure(let message)):
                    self.errorManager.showError(message)
                case .success(.success(let user)):
                    self.myUser = user
                    self.navigationManager.navigateTo(from: .signUp, to: .tabView)
                    
                }
            }
            appLoadingManager.stopLoading()
            
        } catch {
            appLoadingManager.stopLoading()
            self.errorManager.showError(error.localizedDescription)
        }
    }
    
    func signByGoogleOAuth(pageFrom prevScreen : Screen) async {
        do {
            appLoadingManager.startLoading()
            try await authManager.googleOauth() { result in
                switch result {
                case .failure(.failure(let message)):
                    self.errorManager.showError(message)
                case .success(.success(let user)):
                    self.myUser = user
                    self.appLoadingManager.stopLoading()
                    self.navigationManager.navigateTo(from: prevScreen, to: .tabView)
                }
            }
        } catch {
            appLoadingManager.stopLoading()
            self.errorManager.showError(error.localizedDescription)
        }
    }
    
    func signOut(from prevScreen: Screen) async {
        do {
            
            appLoadingManager.startLoading()
            myUser = nil
            try authManager.logout()
            appLoadingManager.stopLoading()
            navigationManager.navigateTo(from: prevScreen, to: .signIn)
        } catch {
            appLoadingManager.stopLoading()
            self.errorManager.showError(error.localizedDescription)
        }
    }
    
    func getAuthenticatedUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func loadAuthenticatedUser() async {
        if let user = getAuthenticatedUser() {
            self.myUser = user
            navigationManager.navigateTo(from: .tabView, to: .tabView)
        } else {
            if checkFirstLaunched() != nil {
                navigationManager.navigateTo(from: .signIn, to: .signIn)
            } else {
                navigationManager.navigateTo(from: .onboarding, to: .onboarding)
            }
        }
    }
    
    func getUserAvatar() async {
        guard myUser != nil else { return }
        // Логика загрузки аватара
    }
    
    func changePhoto(image: UIImage?) {
        // Логика изменения фото
    }
    
    func checkFirstLaunched() -> String? {
        return userDefaultStorageManager.getStringValue(key: .isFirstLaunch)
    }
}
