//
//  LocationManager.swift
//  MyBike
//
//  Created by Aung Ko Min on 11/1/22.
//

import CoreLocation
import CoreLocationUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    @Published var address: Item.Address?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let location = locations.first {
            Task {
                guard let address = await GeoCoder.getAddress(from: location) else { return }
    
                DispatchQueue.main.async {
                    self.address = address
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocation()
    }
    
    func requestLocation() {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }else {
            manager.requestWhenInUseAuthorization()
        }
    }
    deinit{
        manager.stopUpdatingLocation()
    }
}
