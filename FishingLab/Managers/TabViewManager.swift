//
//  TabViewManager.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 21.09.2024.
//


import SwiftUI

enum TabScreen {
    case profile
    case googleMap((() -> Void)? = nil, Bool = true)
    case points
}

@MainActor
class TabViewManager: ObservableObject {
    @Published var currentTab: TabScreen = .profile
    @Published var currentTabAppBarTitle: String = "Profile"
    var previousTab: TabScreen = .googleMap()
    static var shared = TabViewManager()
    var animation = Animation.easeIn(duration:0.3)
    
    
    
    func navigateTo(from prevTab: TabScreen, to nextTab: TabScreen, title appBarTitle: String = "") {
        DispatchQueue.main.async {
            withAnimation(self.animation) {
                self.previousTab = prevTab
                self.currentTab = nextTab
                self.currentTabAppBarTitle = appBarTitle
            }
        }
    }
//    
//    func pop() {
//        DispatchQueue.main.async {
//            let oldCurrentScreen : Screen = self.currentScreen
//            withAnimation(self.animation) {
//                self.currentScreen = self.previousScreen
//                self.previousScreen = oldCurrentScreen
//            }
//        }
//    }
}
