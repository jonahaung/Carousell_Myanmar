//
//  MapView.swift
//  MyBike
//
//  Created by Aung Ko Min on 6/12/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    let coordinate: CLLocationCoordinate2D
    @State private var title = "Location"
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinate, span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))))
            .task {
                GeoCoder.getAddress(from: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { address, _ in
                    guard let address = address else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.title = address.township + " " + address.state
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
    }
}
