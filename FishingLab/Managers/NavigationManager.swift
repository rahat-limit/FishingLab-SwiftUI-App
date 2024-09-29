//
//  NavigationManager.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 19.09.2024.
//

import SwiftUI

enum Screen {
    case empty
    case onboarding
    case signIn
    case signUp
    case forgotPassword
    case tabView
}

@MainActor
class NavigationManager: ObservableObject {
    @Published var currentScreen: Screen = .empty
    var previousScreen: Screen = .onboarding
    static var shared = NavigationManager()
    var animation = Animation.easeIn(duration:0.3)
    
    
    
    func navigateTo(from prevScreen: Screen, to nextScreen: Screen) {
        DispatchQueue.main.async {
            withAnimation(self.animation) {
                self.previousScreen = prevScreen
                self.currentScreen = nextScreen
            }
        }
    }
    
    func pop() {
        DispatchQueue.main.async {
            let oldCurrentScreen : Screen = self.currentScreen
            withAnimation(self.animation) {
                self.currentScreen = self.previousScreen
                self.previousScreen = oldCurrentScreen
            }
        }
    }
}
