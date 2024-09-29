//
//  ExpandedButton.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 19.09.2024.
//

import SwiftUI

struct ExpandedButton: View {
    var text : String = "Sign In"
    var action : () -> Void = {}
    var color : Color = Color.buttonColor
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .h2Bold()
                .padding(.vertical, 18)
                .frame(maxWidth: .infinity)
                .background(
                    color
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
        })
    }
}

#Preview {
    ExpandedButton()
}
