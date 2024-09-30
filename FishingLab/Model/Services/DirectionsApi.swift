//
//  DirectionsApi.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 22.09.2024.
//

import SwiftUI
import Foundation
import CoreLocation
import GoogleMaps

class DirectionsApi {
    
    func fetchRoute(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping (GMSPath?) -> Void) {
        
        let apiKey = ""
        let originString = "\(origin.latitude),\(origin.longitude)"
        let destinationString = "\(destination.latitude),\(destination.longitude)"
        
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(originString)&destination=\(destinationString)&key=\(apiKey)"
        print(urlString)
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let routes = json["routes"] as? [[String: Any]],
                   let route = routes.first,
                   let polyline = route["overview_polyline"] as? [String: Any],
                   let points = polyline["points"] as? String {
                    let path = GMSPath(fromEncodedPath: points)
                    completion(path)
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }
        
        task.resume()
    }
}
