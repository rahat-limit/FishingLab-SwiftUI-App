//
//  OnBoardingCard.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 19.09.2024.
//

import SwiftUI

struct OnBoardingCard: View {
    var title : String = "map and navigation"
    var image : String = "intro_1"
    var description : String = "Look for new places and share\n with others"
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width / 2 - 30)
                .background(
                    ZStack {
                        Circle()
                            .fill(Color.backgroundColor)
                            .stroke(Color.strokeColor, lineWidth: 7)
                            .frame(width: UIScreen.main.bounds.width / 2 + 90, height:  UIScreen.main.bounds.width / 2 + 90)
                        Circle()
                            .fill(Color.strokeColor)
                            .stroke(Color.strokeColor, lineWidth: 17)
                            .frame(width: UIScreen.main.bounds.width / 2 + 20, height: UIScreen.main.bounds.width / 2 + 20)
                            .shadow(radius: 15)
                    }
                )
                .padding(.bottom, UIScreen.main.bounds.width / 4 - 10)
            Text(title)
                .h1()
                .padding(.bottom, 12)
            Text(description)
                .h3()
                .multilineTextAlignment(.center)
                
        }
    }
}

#Preview {
    OnBoardingCard()
}
