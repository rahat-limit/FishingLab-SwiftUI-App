//
//  ValidationHelper.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 20.09.2024.
//

import SwiftUI

class ValidationHelper {
    func isValid(values: [String]) -> Bool {
        for value in values {
            if value.isEmpty {
                return false
            }
        }
        return true
    }
}
