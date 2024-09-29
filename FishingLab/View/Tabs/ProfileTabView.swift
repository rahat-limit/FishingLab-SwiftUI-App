//
//  ProfileTabView.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 21.09.2024.
//

import SwiftUI

struct ProfileTabView: View {
    @EnvironmentObject var authViewModel : AuthViewModelImpl
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                Image(systemName: "person")
                    .resizable() // Make the image resizable
                    .aspectRatio(contentMode: .fill) // Keep the aspect ratio
                    .padding()
                    .frame(width: 60, height: 60) // Set the desired size
                    .padding()
                    .background(
                        Circle().stroke(lineWidth: 1)
                    )
                    .foregroundStyle(.black)
                (Text("a") + Text("@") + Text("gmail.com"))
                    .font(Font.custom("Montserrat-Medium", size: 26))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                ExpandedButton(text: "Sign Out", action: {
                    Task {
                        await authViewModel.signOut(from: .empty)
                    }
                }, color: Color.red.opacity(0.7))
                .padding()
                Spacer()
            }
            
        }
    }
}

#Preview {
    ProfileTabView()
}
