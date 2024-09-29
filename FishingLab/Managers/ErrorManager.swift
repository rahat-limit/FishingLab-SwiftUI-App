//
//  ErrorManager.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 20.09.2024.
//

import SwiftUI
import Combine

@MainActor
class ErrorManager: ObservableObject {
    static var shared = ErrorManager()
    @Published var currentError: ErrorWrapper? = nil
    @Published var showSnackbar = false
    
    func showError(_ message: String) {
        Task { @MainActor in
            currentError = ErrorWrapper(message: message)
            showSnackbar = true
        }
    }
    
    func dismissError() {
        Task { @MainActor in
            currentError = nil
            showSnackbar = false
        }
    }
}
