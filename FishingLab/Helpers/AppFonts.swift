//
//  AppFonts.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 19.09.2024.
//

import SwiftUI

extension Text {
    func h1() -> some View {
        self.font(Font.custom("BebasNeue", size: 40))
            .foregroundColor(Color.primaryColor)
            .fontWeight(.bold)
    }
    func h1Small() -> some View {
        self.font(Font.custom("BebasNeue", size: 30))
            .foregroundColor(Color.primaryColor)
            .fontWeight(.bold)
    }
    func h2() -> some View {
        self.font(Font.custom("Montserrat-Medium", size: 21))
            .foregroundColor(Color.primaryColor)
            .fontWeight(.medium)
    }
    
    
    func h2Bold() -> some View {
        self.font(Font.custom("Montserrat-Medium", size: 21))
            .foregroundColor(Color.primaryColor)
            .fontWeight(.bold)
    }
    
    func h2BoldBlack() -> some View {
        self.font(Font.custom("Montserrat-Medium", size: 21))
            .foregroundColor(Color.black)
            .fontWeight(.bold)
    }
    
    
    func h3() -> some View {
        self.font(Font.custom("Montserrat-Medium", size: 18))
            .foregroundColor(Color.secondaryColor)
            .fontWeight(.regular)
    }
    func h4(color: Color = Color.white.opacity(0.8)) -> some View {
        self
            .font(.system(size: 16))
            .foregroundColor(color)
            .fontWeight(.regular)
            
    }
}
