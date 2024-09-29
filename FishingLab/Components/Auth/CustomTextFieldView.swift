//
//  CustomTextFieldView.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 19.09.2024.
//

import SwiftUI

struct CustomTextFieldView: View {
    @Binding var text: String
    var placeholder: String
    var placeholderColor: Color = Color.primaryColor
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.backgroundColor
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
                    .padding(.leading, 21)
            }
            TextField("", text: $text)
                .padding(.horizontal, 4)
                .foregroundStyle(Color.primaryColor)
                .padding(.horizontal, 18)
                .padding(.vertical, 20)
                .background(
                    Color.primaryColor.opacity(0.5)
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
        }
        
    }
}
#Preview {
    CustomTextFieldView(text: .constant(""), placeholder: "Text", placeholderColor: Color.white)
}
