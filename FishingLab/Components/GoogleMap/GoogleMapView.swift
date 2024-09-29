//
//  GoogleMapView.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 21.09.2024.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    var manager: GoogleMapManager

    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        manager.setMapView(mapView)
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {}
}
