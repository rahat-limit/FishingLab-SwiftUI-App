//
//  CustomSnackbarView.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 20.09.2024.
//

import SwiftUI

struct CustomSnackbarView: View {
    let message: String
    @Binding var isVisible: Bool

    var body: some View {
        VStack {
            Spacer()
            if isVisible {
                HStack {
                    Text(message)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            isVisible = false
                        }
                    }) {
                        Text("Dismiss")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    }
                }
                .padding()
                .background(Color.red.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal)
                .shadow(radius: 10)
                .transition(.move(edge: .bottom))
                .animation(.easeInOut(duration: 0.3))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isVisible = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CustomSnackbarView(message: "Error", isVisible: .constant(true))
}
