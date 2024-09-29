//
//  MapViewModel.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 25.09.2024.
//

import SwiftUI
import CoreLocation


@MainActor
class MapViewModelImpl : ObservableObject {
    static var shared = MapViewModelImpl()
    @Published var points : [PointModel] = [
        PointModel(title: "The Spice Route", description: "A Journey Through Flavors: Dive into a world of spices and aromas at The Spice Route, where each dish tells a story from the Far East to the Mediterranean. Specializing in bold, flavorful cuisine, our menu offers a unique fusion of traditional recipes with modern twists.", coords: CLLocationCoordinate2D(latitude: 51.159311, longitude: 71.492252)),
        PointModel(title: "Harvest & Hearth", description: "Farm-to-Table Excellence: Experience the freshness of seasonal ingredients at Harvest & Hearth. Our dishes are thoughtfully crafted using locally sourced produce, meats, and grains, bringing you rustic, heartwarming meals in a cozy, intimate setting.", coords: CLLocationCoordinate2D(latitude: 51.128990,  longitude: 71.387701)),
        PointModel(title: "Coastal Breeze Bistro", description: "A Taste of the Ocean: Savor the freshest seafood at Coastal Breeze Bistro. From grilled octopus to buttery lobster rolls, our menu reflects the vibrant flavors of coastal regions around the world, served with a side of ocean views.", coords: CLLocationCoordinate2D(latitude: 51.196411,   longitude: 71.434059)),
        PointModel(title: "Urban Roots", description: "Green, Healthy, Delicious: Urban Roots is a plant-based haven offering creative vegan and vegetarian dishes that are as tasty as they are sustainable. Whether you're after a quick smoothie bowl or a hearty grain salad, we’ve got something to nourish your body and soul.", coords: CLLocationCoordinate2D(latitude: 51.196411,   longitude: 71.434059)),
        PointModel(title: "The Rusty Skillet", description: "Hearty Comfort Food with a Twist: At The Rusty Skillet, comfort food classics meet gourmet innovation. Whether it's our signature cast-iron skillet mac & cheese or the slow-cooked short ribs, you'll find dishes that are both familiar and exciting.", coords: CLLocationCoordinate2D(latitude: 51.196411,   longitude: 71.434059))
    ]
    
    
    func addPoint(point: PointModel) {
        points.append(point)
    }
    
    func removePoint(point: PointModel) {
        points.removeAll(where: {$0.id == point.id})
    }
}
