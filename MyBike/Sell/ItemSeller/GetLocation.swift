//
//  GetLocation.swift
//  MyBike
//
//  Created by Aung Ko Min on 5/12/21.
//

import Foundation
import CoreLocation

public class GetLocation: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var locationCallback: ((CLLocation?) -> Void)!
    var locationServicesEnabled = false
    var didFailWithError: Error?
    
    public func run(callback: @escaping (CLLocation?) -> Void) {
        locationCallback = callback
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestWhenInUseAuthorization()
        locationServicesEnabled = CLLocationManager.locationServicesEnabled()
        if locationServicesEnabled { manager.startUpdatingLocation() }
        else { locationCallback(nil) }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        locationCallback(locations.last!)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFailWithError = error
        locationCallback(nil)
        manager.stopUpdatingLocation()
    }
    
    deinit {
        manager.stopUpdatingLocation()
        print("Deinit GetLocation")
    }
}
