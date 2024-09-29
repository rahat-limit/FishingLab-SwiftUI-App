//
//  AuthRedirectLink.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 19.09.2024.
//

import SwiftUI

struct AuthRedirectLink: View {
    var text: String = "Register here"
    var action: () -> Void = {}
    var body: some View {
        HStack {
            Text("Not a member, ").foregroundStyle(Color.primaryColor)
            Button(action: action, label: {
                Text(text)
            })
        }
    }
}

#Preview {
    AuthRedirectLink()
}
