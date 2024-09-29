//
//  FishingLabApp.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 19.09.2024.
//

import SwiftUI
import SwiftData
import FirebaseCore
import GoogleSignIn
import GoogleMaps
import GooglePlaces

class AppDelegate: NSObject, UIApplicationDelegate {
    let GoogleApiKey = "AIzaSyDEys1a_R-rHWpFJp7GTPm8-Uf7f6Np3DE"
//    let GoogleApiKey = ""
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Firebase init
        FirebaseApp.configure()
        // Set Google MAP Api Key
        GMSServices.provideAPIKey(GoogleApiKey)
        GMSPlacesClient.provideAPIKey(GoogleApiKey)
        
        return true
    }
}

@main
struct FishingLabApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var navigationManager = NavigationManager.shared
    @StateObject var appLoadingManager = AppLoadingManager.shared
    @StateObject var errorManager = ErrorManager.shared
    @StateObject var userDefaultStorageManager = UserDefaultStorageManager.shared
    @StateObject var tabViewManager = TabViewManager.shared
    @StateObject var mapViewModel = MapViewModelImpl.shared
    @StateObject var googleMapManager = GoogleMapManager.shared
    @StateObject var authViewModel = AuthViewModelImpl(errorManager: ErrorManager.shared, appLoadingManager: AppLoadingManager.shared, navigationManager: NavigationManager.shared, userDefaultStorageManager: UserDefaultStorageManager.shared)
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                NavigationControllerView()
                    .environmentObject(navigationManager)
                    .environmentObject(errorManager)
                    .environmentObject(appLoadingManager)
                    .environmentObject(authViewModel)
                    .environmentObject(userDefaultStorageManager)
                    .environmentObject(tabViewManager)
                    .environmentObject(mapViewModel)
                    .environmentObject(googleMapManager)
            }.onOpenURL { url in
                //Handle Google Oauth URL
                GIDSignIn.sharedInstance.handle(url)
            }
        }
    }
}
