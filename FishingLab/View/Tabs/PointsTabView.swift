//
//  PointsTabView.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 25.09.2024.
//

import SwiftUI
import CoreLocation

struct PointsTabView: View {
    @EnvironmentObject var mapViewModelImpl : MapViewModelImpl
    @EnvironmentObject var googleMapManager : GoogleMapManager
    @EnvironmentObject var tabViewManager: TabViewManager
    var body: some View {
        
        ScrollView {
            VStack {
                HStack {
                    Text("Points").h2BoldBlack()
                    Spacer()
                }
                ForEach (mapViewModelImpl.points) { point in
                    pointCard(point: point)
                }
                
            }.padding()
        }
    }
    
    func onAppearAction(coords: CLLocationCoordinate2D) {
        googleMapManager.isSheetOpen = false
        googleMapManager.changeMapMode(mode: .nothing)
        googleMapManager.zoomToLocation(at: coords, zoom: 13)
    }
    
    func pointCard(point: PointModel) -> some View {
        Button(action: {
            tabViewManager.navigateTo(from: .points, to: .googleMap({
                onAppearAction(coords: point.coords)
            }, false), title: "\(point.title)")
        }) {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(point.title).h1Small()
                        Spacer()
                        Text("\(point.coords.latitude) - \(point.coords.longitude)")
                            .h4(color: Color.green.opacity(0.5))
                    }
                    
                    Text(point.description).h3().lineLimit(3)
                        
                    
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.buttonColor)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}


#Preview {
    PointsTabView()
        .environmentObject(MapViewModelImpl.shared)
        .environmentObject(TabViewManager.shared)
        .environmentObject(GoogleMapManager.shared)
    
}
