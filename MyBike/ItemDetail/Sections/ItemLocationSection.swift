//
//  ItemLocationSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 6/12/21.
//

import SwiftUI
import MapKit

struct ItemLocationSection: View {
    
    @StateObject var itemViewModel: ItemViewModel
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    @State private var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @State private var snapshot: UIImage?
    
    var body: some View {
        Group {
            if let snapshot = snapshot {
                Image(uiImage: snapshot)
                    .resizable()
                    .tapToPush(MapView(coordinate: coordinate).anyView)
            }else {
                EmptyView()
            }
            HStack {
                Text(itemViewModel.item.address.township)
                    .tapToPushItemsList(.search(.Address(.township(itemViewModel.item.address.township))))
                Spacer()
                Text(itemViewModel.item.address.state)
                    .tapToPushItemsList(.search(.Address(.state(itemViewModel.item.address.state))))
            }.padding()
        }
        .task {
            getLocation()
        }
        .insetGroupSectionStyle(0)
    }

    private func getLocation() {
        let address = itemViewModel.item.address
        let addressText = "\(address.township), \(address.state)"
        getLocation(from: addressText) { location in
            if let location = location {
                DispatchQueue.main.async {
                    self.takeSnapShot(coordinate: location.coordinate)
                }
            }else {
                self.getLocation(from: address.state) { location in
                    guard let location = location else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.takeSnapShot(coordinate: location.coordinate)
                    }
                }
            }
        }
    }
    
    private func getLocation(from text: String, completion: @escaping (CLLocation?) -> Void) {
        GeoCoder.getLocation(from: text) { location, error in
            completion(location)
        }
    }
    
    private func takeSnapShot(coordinate: CLLocationCoordinate2D) {
        
        let options = MKMapSnapshotter.Options()

        options.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        options.scale = UIScreen.main.scale

        options.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 2)
        options.showsBuildings = true

        MKMapSnapshotter(options: options).start() { snapshot, error in
            guard let snapshot = snapshot else {
                return
            }
            DispatchQueue.main.async {
                self.coordinate = coordinate
                self.snapshot = snapshot.image
            }
        }
    }
}
