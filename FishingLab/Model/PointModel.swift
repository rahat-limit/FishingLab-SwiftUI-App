//
//  PointModel.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 25.09.2024.
//

import SwiftUI
import CoreLocation

class PointModel: Identifiable {
    var id = UUID()
    var title : String
    var description : String
    var coords : CLLocationCoordinate2D
    
    init(title: String, description: String, coords: CLLocationCoordinate2D) {
        self.title = title
        self.description = description
        self.coords = coords
    }
}
