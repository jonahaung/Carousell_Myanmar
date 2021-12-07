//
//  SellView.swift
//  MyBike
//
//  Created by Aung Ko Min on 20/10/21.
//

import SwiftUI
import MapKit

struct SellView: View {
    
    @StateObject private var itemSeller = ItemSeller()
    @EnvironmentObject var authenticationService: AuthenticationService
    

    var body: some View {
        Form {
            Section {
                SellImagesSection(itemSeller: itemSeller)
                    .listRowInsets(EdgeInsets())
                Button.init("Reset Images", action: {
                    itemSeller.sellingImages.removeAll()
                })
            }
            Section {
                Text(itemSeller.category.title)
                    .tapToPush(CategoryPickerView(category: $itemSeller.category).anyView)
                
                TextField("Listing Title", text: $itemSeller.title)
                    .autocapitalization(.words)
                TextField("Price $", text: $itemSeller.price)
                    .keyboardType(.decimalPad)
            }
            
            Section {
                Picker("Condition", selection: $itemSeller.condition) {
                    ForEach(Item.Condition.allCases) {
                        Text($0.description)
                            .foregroundColor(.accentColor)
                    }
                }
                Picker("Dealing Type", selection: $itemSeller.dealType) {
                    ForEach(DealType.allCases) {
                        Text($0.description)
                            .foregroundColor(.accentColor)
                    }
                }
            }
            
            Section {
                Text("Description")
                    .foregroundColor(.tertiaryLabel)
                DynamicHeightTextView(text: $itemSeller.detailText)
                    .listRowSeparator(.hidden)
            }
            
            SellAddressSection(address: $itemSeller.address)
            
            Section{
                TextField("Phone Number", text: .constant(""))
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
            }
            
            Section {
                Text("Submit").formSubmitButtonStyle(.accentColor).onTapGesture {
                    itemSeller.errorAlert = AlertObject(title: "Are you sure to publish this item?", message: nil, action: {
                        if let person = authenticationService.person {
                            itemSeller.publish(person: person)
                        }
                    })
                }
            }.listRowInsets(EdgeInsets())
        }
        .sheet(item: $itemSeller.fullScreenType, onDismiss: {
        }, content: { type in
            switch type {
            case .imagesPicker:
                ImagePickerMultiple{ images in
                    for image in images {
                        itemSeller.sellingImages.append(SellingImage(image: image))
                    }
                }.edgesIgnoringSafeArea(.all)
            }
        })
        .navigationBarTitle("Sell")
        .navigationBarItems(trailing: publishButton)
        .alert(item: $itemSeller.errorAlert) { Alert(alertObject: $0) }
    }
    
    
    private var publishButton: some View {
        HStack {
            progressView
            Button("Publish") {
                itemSeller.errorAlert = AlertObject(title: "Are you sure to publish this item?", message: nil, action: {
                    if let person = authenticationService.person {
                        itemSeller.publish(person: person)
                    }
                })
            }
        }
    }
    
    private func check() {
        guard !itemSeller.sellingImages.isEmpty else {
            itemSeller.fullScreenType = .imagesPicker
            return
        }
    }
    
    var progressView: some View {
        ProgressView().opacity(itemSeller.showLoading ? 1 : 0)
    }
}

extension Alert: Identifiable {
    public var id: String {
        return UUID().uuidString
    }
    
}
