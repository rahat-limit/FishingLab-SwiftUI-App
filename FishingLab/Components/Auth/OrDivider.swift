//
//  OrDivider.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 19.09.2024.
//

import SwiftUI

struct OrDivider: View {
    var body: some View {
        HStack {
            // Линия слева
            Divider()
                .frame(width: 100, height: 1)
                .background(Color.white) // Цвет линии
            
            // Текст "Or" по центру
            Text("Or")
                .foregroundColor(.white)
                .padding(.horizontal, 8)
            
            // Линия справа
            Divider()
                .frame(width: 100, height: 1)
                .background(Color.white) // Цвет линии
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
}

#Preview {
    OrDivider()
}
