//
//  GoogleMapTabView.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 21.09.2024.
//

import SwiftUI
import CoreLocation

struct GoogleMapTabView: View {
    var onAppearAction: (() -> Void)?
    var locationButtonVisible : Bool = true
    @EnvironmentObject var mapManager : GoogleMapManager
    
    
    var body: some View {
        ZStack {
            VStack {
                GoogleMapView(manager: mapManager)
                    .edgesIgnoringSafeArea(.all)
            }
            .sheet(isPresented: $mapManager.isSheetOpen, content: {
                SheetPanelView(initialLocation: mapManager.initialLocation,
                               destination: mapManager.destination, myLocationAction: {
                    mapManager.changeMapMode(mode: .pickIntitialLocation)
                    mapManager.isSheetOpen.toggle()
                },
                               destinationAction: {
                    mapManager.changeMapMode(mode: .pickDestination)
                    mapManager.isSheetOpen.toggle()
                }
                )
            })
            .onAppear {
                mapManager.startUpdatingLocation()
                if let action = onAppearAction {
                    action()
                }
            }
            if locationButtonVisible {
                Button(action: {
                    if (!mapManager.isSheetOpen) {
                        mapManager.isSheetOpen.toggle()
                    }
                }, label: {
                    Image(systemName: "location")
                        .imageScale(.large)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .padding(20)
                        .background(
                            Circle().fill(Color.backgroundColor)
                        )
                        .position(x: UIScreen.main.bounds.width - 50, y: UIScreen.main.bounds.height - 200)
                })
            }
        }
    }
}

#Preview {
    GoogleMapTabView()
}
