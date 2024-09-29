//
//  AuthManager.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 20.09.2024.

import Foundation
import FirebaseAuth
import UIKit
import FirebaseCore
import GoogleSignIn


enum AuthSuccess {
    case success(User)
}

enum AuthError : Error {
    case failure(String)
}

protocol AuthManager {
    func signUpUser(email: String, password: String, completion: @escaping (Result<AuthSuccess, AuthError>) -> Void) async throws
    func signInUser(email: String, password: String, completion: @escaping (Result<AuthSuccess, AuthError>) -> Void) async throws
    func googleOauth(completion: @escaping (Result<AuthSuccess, AuthError>) -> Void) async throws
    func logout() async throws
}

final class AuthManagerImpl : AuthManager {
    func signUpUser(email: String, password: String, completion: @escaping (Result<AuthSuccess, AuthError>) -> Void) async throws  {
        do {
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            
            completion(.success(.success(authDataResult.user)))
        } catch let error as NSError {
            switch error.code {
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                completion(.failure(.failure("Email is already in use.")))
            case AuthErrorCode.invalidEmail.rawValue:
                completion(.failure(.failure("Invalid email address.")))
            case AuthErrorCode.weakPassword.rawValue:
                completion(.failure(.failure("Password is too weak.")))
            case AuthErrorCode.networkError.rawValue:
                completion(.failure(.failure("Network error. Please try again later.")))
            case AuthErrorCode.wrongPassword.rawValue:
                completion(.failure(.failure("Incorrect Password.")))
            case AuthErrorCode.userDisabled.rawValue:
                completion(.failure(.failure("User does not exist.")))
            default:
                completion(.failure(.failure(error.localizedDescription)))
            }
        }
    }
    
    func signInUser(email: String, password: String, completion: @escaping (Result<AuthSuccess, AuthError>) -> Void) async throws  {
        
        do {
            let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
            completion(.success(.success(authDataResult.user)))
        } catch let error as NSError {
            print(error)
            switch error.code {
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                completion(.failure(.failure("Email is already in use.")))
            case AuthErrorCode.invalidEmail.rawValue:
                completion(.failure(.failure("Invalid email address.")))
            case AuthErrorCode.weakPassword.rawValue:
                completion(.failure(.failure("Password is too weak.")))
            case AuthErrorCode.networkError.rawValue:
                completion(.failure(.failure("Network error. Please try again later.")))
            case AuthErrorCode.wrongPassword.rawValue:
                completion(.failure(.failure("Incorrect Password.")))
            case AuthErrorCode.userDisabled.rawValue:
                completion(.failure(.failure("User does not exist.")))
            default:
                completion(.failure(.failure(error.localizedDescription)))
            }
        }
    }
    func googleOauth(completion: @escaping (Result<AuthSuccess, AuthError>) -> Void) async throws {
        // Google sign-in
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            return DispatchQueue.main.async {
                completion(.failure(.failure("Failed to get clientID")))
            }
        }
        
        // Create Google Sign In configuration object
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Ensure UI-related actions are performed on the main thread
        await MainActor.run {
            // Get the rootViewController from the main thread
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootViewController = windowScene.windows.first?.rootViewController else {
                DispatchQueue.main.async {
                    completion(.failure(.failure("There is no root view controller!")))
                }
                return
            }
            
            // Google sign-in authentication response
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(.failure(error.localizedDescription)))
                    }
                    return
                }
                
                guard let user = signInResult?.user,
                      let idToken = user.idToken?.tokenString else {
                    DispatchQueue.main.async {
                        completion(.failure(.failure("Unexpected error occurred, please retry")))
                    }
                    return
                }
                
                // Firebase auth
                Task {
                    do {
                        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                        let authResultData = try await Auth.auth().signIn(with: credential)
                        DispatchQueue.main.async {
                            completion(.success(.success(authResultData.user)))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(.failure(error.localizedDescription)))
                        }
                    }
                }
            }
        }
    }
    
    
    func logout() throws {
        try Auth.auth().signOut()
    }
}
