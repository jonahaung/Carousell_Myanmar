//
//  GeoCoder.swift
//  MyBike
//
//  Created by Aung Ko Min on 6/12/21.
//

import Foundation
import CoreLocation
import FirebaseFirestore

final class GeoCoder {
    
    static func getLocation(from address: String, _ completion: @escaping (_ location: CLLocation?, _ error: Error?) -> ()) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            guard let placemark = placemarks?.first,
                  let lat = placemark.location?.coordinate.latitude,
                  let lon = placemark.location?.coordinate.longitude
            else {
                completion(nil, error)
                return
            }
            completion(CLLocation(latitude: lat, longitude: lon), error)
        }
    }
    
    static func getAddress(from location: CLLocation) async -> Item.Address? {
        
        guard let placemarks = try? await CLGeocoder().reverseGeocodeLocation(location), let placemark = placemarks.first else {
            return nil

        }

        guard let township = placemark.locality, let state = placemark.administrativeArea else {
            return nil
        }
        return Item.Address(state: state, township: township)
    }
    
    
    
    static func getAddress(from location: CLLocation, _ completion: @escaping (_ address: Item.Address?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) {
            guard let placemark = $0?.first, let township = placemark.locality, let state = placemark.administrativeArea else {
                completion(nil, $1)
                return
            }
            completion(Item.Address.init(state: state, township: township), nil)
//            var address = ""
//            if let subThoroughfare = palcemark?.subThoroughfare {
//                address = address + subThoroughfare + ", "
//            }
//            if let thoroughfare = palcemark?.thoroughfare {
//                address = address + thoroughfare + ", "
//            }
//            if let locality = palcemark?.locality {
//                address = address + locality + ", "
//            }
//            if let subLocality = palcemark?.subLocality {
//                address = address + subLocality + ", "
//            }
//            if let administrativeArea = palcemark?.administrativeArea {
//                address = address + administrativeArea + ", "
//            }
//            if let postalCode = palcemark?.postalCode {
//                address = address + postalCode + ", "
//            }
//            if let country = palcemark?.country {
//                address = address + country + ", "
//            }
//            if address.trimmed.last == "," {
//                address = String(address.trimmed.dropLast())
//            }
//            completion(address,$1)
        }
    }
}

extension CLLocationCoordinate2D {
    var geoPoint: GeoPoint {
        .init(latitude: self.latitude, longitude: self.longitude)
    }
}

extension GeoPoint {
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: self.latitude, longitude: self.longitude)
    }
}
