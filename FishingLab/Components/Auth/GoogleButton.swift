//
//  GoogleButton.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 19.09.2024.
//

import SwiftUI

struct GoogleButton: View {
    var action : () -> Void = {}
    var body: some View {
        Button(action: action, label: {
            Image("google").resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 90)
                .padding(.vertical, 20)
        })
    }
}

#Preview {
    GoogleButton()
}
