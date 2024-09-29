//
//  SideBarStack.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 21.09.2024.
//

import SwiftUI


struct SideMenuView: View {
    @EnvironmentObject var tabViewManager : TabViewManager
    @Binding var isOpen: Bool
    @Binding var text: String
    let width: CGFloat = 270
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                EmptyView()
            }
            .background(Color.gray.opacity(0.3))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .opacity(1.0)
            .animation(.easeIn(duration: 0.25))
            .onTapGesture {
                self.isOpen = false
            }
            HStack(alignment: .top){
                VStack {
                    HStack {
                        Text("FishingLab")
                            .h1()
                            .padding(.top, 100)
                            .padding(.leading, 32)
                        Spacer()
                    }
                    SideMenuContentView(topPadding: 5,systemName: "person", text: "Profile", bindText: $text, isOpen: $isOpen) {
                        tabViewManager.navigateTo(from: tabViewManager.previousTab, to: .profile, title: "Profile")
                    }
                    SideMenuContentView(systemName: "map", text: "Google Map", bindText: $text, isOpen: $isOpen) {
                        tabViewManager.navigateTo(from: tabViewManager.previousTab, to: .googleMap(), title: "Google Map")
                    }
                    SideMenuContentView(systemName: "mappin.circle.fill", text: "Points", bindText: $text, isOpen: $isOpen) {
                        tabViewManager.navigateTo(from: tabViewManager.previousTab, to: .points, title: "Points")
                    }
                    Spacer()
                }
                .frame(width: width)
                .background(Color.sidebarColor)
                .offset(x: self.isOpen ? 0 : -self.width)
                .animation(.easeIn(duration: 0.25))
                Spacer()
            }
        }
    }
}
struct SideMenuContentView: View {
    let topPadding: CGFloat
    let systemName: String
    let text: String
    let action: () -> Void
    @Binding var bindText: String
    @Binding var isOpen: Bool
    init(topPadding: CGFloat = 15, systemName: String, text: String, bindText: Binding<String>, isOpen: Binding<Bool>, action: @escaping () -> Void = {}) {
        self.topPadding = topPadding
        self.systemName = systemName
        self._bindText = bindText
        self._isOpen = isOpen
        self.text = text
        self.action = action
    }
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .foregroundColor(Color.primaryColor)
                .imageScale(.large)
                .frame(width: 32.0)
            Text(text)
                .h3()
                .foregroundColor(Color.white)
            Spacer()
        }
        .padding(.top, topPadding)
        .padding(.leading, 32)
        .onTapGesture {
            self.bindText = self.text
            self.isOpen = false
            action()
        }
    }
}

#Preview {
    SideMenuView(isOpen: .constant(true), text: .constant(""))
        .environmentObject(TabViewManager())
}



