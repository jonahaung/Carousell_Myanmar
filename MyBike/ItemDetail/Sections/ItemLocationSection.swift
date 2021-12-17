//
//  ItemLocationSection.swift
//  MyBike
//
//  Created by Aung Ko Min on 6/12/21.
//

import SwiftUI
import MapKit

struct ItemLocationSection: View {
    
    @ObservedObject var itemViewModel: ItemViewModel
    
    @State private var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @State private var snapshot: UIImage?
    
    var body: some View {
        Group {
            if let snapshot = snapshot {
                Image(uiImage: snapshot)
                    .resizable()
                    .cornerRadius(5)
                    .tapToPush(MapView(coordinate: coordinate).anyView)
            }else {
                EmptyView()
            }
            HStack {
                let address = itemViewModel.item.address
                Text(address.township)
                    .tapToPushItemsList(.search([.Address(.township(address.township))]))
                Spacer()
                Text(address.state)
                    .tapToPushItemsList(.search([.Address(.state(address.state))]))
            }.padding()
        }
        .task {
            getLocation()
        }
        .insetGroupSectionStyle(0)
    }

    private func getLocation() {
        guard snapshot == nil, coordinate.latitude == 0 else { return }
        print("location")
        let address = itemViewModel.item.address
        let addressText = "\(address.township), \(address.state), Myanmar"
        
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

        options.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        options.scale = UIScreen.main.scale
//        options.mapType = .hybridFlyover
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
