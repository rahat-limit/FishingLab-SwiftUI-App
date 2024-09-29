//
//  GoogleMapManager.swift
//  FishingLab
//
//  Created by Rakhat Cyanid on 22.09.2024.
import GoogleMaps
import CoreLocation

enum MapMode {
    case nothing
    case pickIntitialLocation
    case pickDestination
}

class GoogleMapManager: NSObject, CLLocationManagerDelegate, GMSMapViewDelegate, ObservableObject {
    static var shared = GoogleMapManager()
    private var mapView: GMSMapView?
    private var locationManager = CLLocationManager()
    private var previousLocation: CLLocation?
    @Published var myLocation: CLLocationCoordinate2D? // Хранение текущей локации
    @Published var mapMode : MapMode = .nothing
    @Published var isSheetOpen = true
    @Published var initialLocation : CLLocationCoordinate2D?
    @Published var destination : CLLocationCoordinate2D?
    private var markers: [GMSMarker] = []
    private var currentPolyline: GMSPolyline?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Initialize map view
    func setMapView(_ mapView: GMSMapView) {
        self.mapView = mapView
        self.mapView?.isMyLocationEnabled = true
        self.mapView?.settings.myLocationButton = true
        self.mapView?.delegate = self
        
        // Set an initial zoom and camera position, maybe based on a default location
        if let myLocation = myLocation {
            zoomToLocation(at: myLocation)
        } else {
            // Fallback to a default location if user's location is not available yet
            let defaultLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // San Francisco, for example
            zoomToLocation(at: defaultLocation)
        }
    }
    
    // Start updating user location
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    // CLLocationManager delegate method to handle location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else { return }

//        // Update myLocation with the current location
//        myLocation = location.coordinate
//        
//        // Zoom in to current location when it is first set
//        zoomToLocation(at: location.coordinate)
        
//        self.previousLocation = location
    }

    // CLLocationManager delegate to handle authorization changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    // Helper function to zoom to a specific location
    func zoomToLocation(at coordinate: CLLocationCoordinate2D, zoom zoomLevel: Float = 15) {
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude,
                                              longitude: coordinate.longitude,
                                              zoom: zoomLevel)
        mapView?.animate(to: camera)
    }
    
    func addMarker(at coordinate: CLLocationCoordinate2D) {
            let marker = GMSMarker(position: coordinate)
            marker.title = "Marker at (\(coordinate.latitude), \(coordinate.longitude))"
            marker.map = mapView
            markers.append(marker) // Store the marker
        }

        func removeMarker(at coordinate: CLLocationCoordinate2D) {
            if let index = markers.firstIndex(where: { $0.position.latitude == coordinate.latitude && $0.position.longitude == coordinate.longitude }) {
                markers[index].map = nil // Remove from map
                markers.remove(at: index) // Remove from array
            }
        }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("Map tapped at: \(coordinate.latitude), \(coordinate.longitude)")
        switch mapMode {
        case .nothing:
            print("No action on tap")
        case .pickIntitialLocation:
            let lastMaker = initialLocation
            addMarker(at: coordinate) // Add a marker on initial location tap
            initialLocation = coordinate // set to variable
            zoomToLocation(at: coordinate) // zoom in
            changeMapMode(mode: .nothing) // cancel tap action
            drawRoute(prevMarker: lastMaker)
        case .pickDestination:
            let lastMaker = destination
            addMarker(at: coordinate) // Add a marker on destination location tap
            destination = coordinate // set to variable
            zoomToLocation(at: coordinate) // zoom in
            changeMapMode(mode: .nothing) // cancel tap action
            drawRoute(prevMarker: lastMaker)
        }
    }
    
    func changeMapMode(mode mapMode: MapMode) {
        self.mapMode = mapMode
    }
    
    func drawRoute(prevMarker: CLLocationCoordinate2D?) {
        guard let initialLocation = initialLocation, let destination = destination else {
            isSheetOpen = true
            return
        }
        
        // Remove existing polyline if it exists
        if let existingPolyline = currentPolyline {
            existingPolyline.map = nil // Remove from map
        }
        
        // Remove last marker
        if let coords = prevMarker {
            removeMarker(at: coords)
        }
        
        DirectionsApi().fetchRoute(from: initialLocation, to: destination) { [weak self] path in
            guard let self = self, let path = path else { return }
            DispatchQueue.main.async {
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = .blue
                polyline.strokeWidth = 5.0
                polyline.map = self.mapView
                self.currentPolyline = polyline // Store the new polyline
                
                self.fitMarkersInView(initialLocation: initialLocation, destination: destination)
            }
        }
    }

    
    func fitMarkersInView(initialLocation: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        let bounds = GMSCoordinateBounds(coordinate: initialLocation, coordinate: destination)
        let cameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 50.0) // Adjust padding as necessary
        mapView?.animate(with: cameraUpdate)

        // Optionally, you can zoom out further by creating a new camera position
        let cameraPosition = mapView?.camera
        let desiredZoomLevel: Float = 13.0 // Set desired zoom level to zoom out

        // Set the camera with the calculated center and desired zoom level
        if let center = cameraPosition?.target {
            let newCameraPosition = GMSCameraPosition.camera(withLatitude: center.latitude,
                                                              longitude: center.longitude,
                                                              zoom: desiredZoomLevel)
            mapView?.animate(to: newCameraPosition)
        }
    }

    
}
