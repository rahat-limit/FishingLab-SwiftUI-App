//
//  SheetPanelView.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 22.09.2024.
//

import SwiftUI
import CoreLocation

struct SheetPanelView: View {
    var initialLocation : CLLocationCoordinate2D?
    var destination : CLLocationCoordinate2D?
    var myLocationAction: () -> Void = {}
    var destinationAction: () -> Void = {}
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "location")
                Text("Route")
                    .font(Font.custom("Montserrat-Medium", size: 21))
                    .foregroundColor(Color.black)
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            
            Button(action: myLocationAction, label: {
                
                HStack {
                    Text("My Location")
                        .font(.system(size: 16))
                        .foregroundColor(Color.black)
                        .fontWeight(.regular)
                    Spacer()
                    if let coords = initialLocation {
                        Text("\(coords.latitude), \(coords.longitude)")
                            .font(.system(size: 16))
                            .foregroundColor(Color.black)
                            .fontWeight(.regular)
                    }
                    
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.backgroundColor, lineWidth: 1)
                )
                
            })
            .padding(.horizontal)
            Button(action: destinationAction, label: {
                HStack {
                    Text("Destination")
                        .h4()
                    Spacer()
                    
                    if let coords = destination {
                        Text("\(coords.latitude), \(coords.longitude)")
                            .h4()
                    }
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.backgroundColor.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            })
            .padding(.horizontal)
            Spacer()
        }
        .padding(.vertical)
        .presentationDetents([.height(200), .height(400)])
        
    }
}

#Preview {
    SheetPanelView()
}
