//
//  OnBoardingView.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 19.09.2024.
//

import SwiftUI

struct OnBoardingView: View {
    @State var currentStep = 0
    @State private var isNavigating = false
    @EnvironmentObject var navigationManager : NavigationManager
    @EnvironmentObject var userDefaultStorageManager : UserDefaultStorageManager
    var listCards: [AnyView] = [
        AnyView(OnBoardingCard()),
        AnyView(OnBoardingCard(title: "Fishing Community", image: "intro_2", description: "Exchange experiences, ask questions and get advice others")),
        AnyView(OnBoardingCard(title: "Catch log", image: "intro_3", description: "Record catches, fish species, size, location, time and other"))
    ]
    @EnvironmentObject var errorManager : ErrorManager
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    TabView(selection: $currentStep) {
                        ForEach(0..<listCards.count, id: \.self) { card in
                            listCards[card].tag(card)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.clear)
                        }
                    }
                    
                    .tabViewStyle(PageTabViewStyle())
                    
                    Button(action: {
                        if (currentStep < listCards.count - 1) {
                            withAnimation {
                                currentStep += 1
                            }
                        } else {
                            userDefaultStorageManager.setValue(value: "launched", key: .isFirstLaunch)
                            navigationManager.navigateTo(from: Screen.onboarding, to: Screen.signIn)
                        }
                    }, label: {
                        Text(currentStep < listCards.count - 1 ? "Next"  : "Start")
                            .h2()
                            .frame(width: 125, height: 40)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .stroke()
                                    .fill(Color.white)
                            )
                    })
                    .padding(.bottom, 50)              }
            }
        }
    }
}

#Preview {
    OnBoardingView().environmentObject(NavigationManager())
}
