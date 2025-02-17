//
//  LocationViewModel.swift
//  Visited
//
//  Created by Furkan Tekin on 13.02.2025.
//
import Foundation
import MapKit
import SwiftUI

class LocationViewModel: ObservableObject {
    @Published var locations: [Location]
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion()
        }
    }
    @Published var mapPosition: MapCameraPosition
    @Published var isShowingLocationList: Bool = false
    var mapRegion: MKCoordinateRegion
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
        let loadedLocations = LocationsDataService.locations
        self.locations = loadedLocations
        guard let firstLocation = loadedLocations.first else {
            fatalError("Locations array is empty!")
        }
        self.mapLocation = firstLocation
        self.mapRegion = MKCoordinateRegion(center: firstLocation.coordinates, span: mapSpan)
        self.mapPosition = MapCameraPosition.region(mapRegion)
    }
    
    func updateMapRegion() {
        withAnimation {
            self.mapRegion = MKCoordinateRegion(center: mapLocation.coordinates, span: mapSpan)
            self.mapPosition = MapCameraPosition.region(mapRegion)
        }
    }
    func showLocationList() {
            isShowingLocationList.toggle()
    }
    func showSelectedLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            isShowingLocationList = false
        }
    }
    func nextButtonPressed() {
        guard let currentIndex = locations.firstIndex (where: { location in
            location == mapLocation
        }) else {
            print("error")
            return
        }
        
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            print("no indices")
            showSelectedLocation(location: locations.first!)
            return
        }
        let nextLocation = locations[nextIndex]
        showSelectedLocation(location: nextLocation)
    }
}
