//
//  SellView.swift
//  MyBike
//
//  Created by Aung Ko Min on 20/10/21.
//

import SwiftUI
import MapKit

struct SellView: View {
    
    enum Field {
        case title, price, description, phoneNumber
    }
    @FocusState private var focusedField: Field?
    
    @EnvironmentObject var authenticationService: AuthenticationService
    @StateObject private var itemSeller = ItemSeller()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Form {
                SellImagesSection(itemSeller: itemSeller)
                Section {
                    FormCell(text: "Category", rightView: Text(itemSeller.category.title).anyView)
                        .tapToPush(CategoryPickerView(category: $itemSeller.category).anyView)
                    
                    FormCell(text: "Title      ", rightView: TextField("Polygon Siskiu D7 2022 M 29er", text: $itemSeller.title).anyView)
                        .autocapitalization(.words)
                        .focused($focusedField, equals: .title)
                    
                    FormCell(text: "Price      ", rightView: TextField("$0000", text: $itemSeller.price).anyView)
                        .keyboardType(.numbersAndPunctuation)
                        .focused($focusedField, equals: .price)
                }
                
                Section {
                    Picker("Condition", selection: $itemSeller.condition) {
                        ForEach(Item.Condition.allCases) {
                            Text($0.description)
                                .font(.Serif())
                                .foregroundStyle(.primary)
                        }
                    }
                    .foregroundStyle(.secondary)
                    
                    Picker("Dealing Type", selection: $itemSeller.dealType) {
                        ForEach(Item.DealType.allCases) {
                            Text($0.description)
                                .font(.Serif())
                                .foregroundStyle(.primary)
                        }
                    }
                    .foregroundStyle(.secondary)
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Description")
                            .foregroundColor(.secondary)
                        
                        TextEditor(text: $itemSeller.detailText)
                            .font(.Serif())
                            .listRowSeparator(.hidden)
                            .focused($focusedField, equals: .description)
                    }
                }
                
                
                Section(footer: submitButton) {
                    FormCell(text: "State", rightView: SellAddressSection(address: $itemSeller.address).anyView)
                        .tapToPush(regionPicker.anyView)
                    
                    FormCell(text: "Phone Numnber", rightView: TextField("Phone Number", text: .constant("")).anyView)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                        .focused($focusedField, equals: .phoneNumber)
                }
            }
            
            if focusedField != nil {
                Button {
                    hideKeyboard()
                } label: {
                    Image(systemName: "chevron.down.circle.fill")
                        .padding()
                }
            }
        }
        .navigationBarTitle("Sell")
        .navigationBarItems(trailing: publishButton)
        .confirmationAlert($itemSeller.errorAlert)
    }
    
    private var regionPicker: some View {
        RegionPicker(address: $itemSeller.address)
    }
    private var submitButton: some View {
        Button {
            hideKeyboard()
            itemSeller.errorAlert = AlertObject(buttonText: "Publish this item", action: {
                if let person = authenticationService.personViewModel?.person {
                    itemSeller.publish(person: person)
                }
            })
        } label: {
            Text("Submit").formSubmitButtonStyle(.accentColor)
        }
    }
    
    private var publishButton: some View {
        HStack {
            ProgressView().opacity(itemSeller.showLoading ? 1 : 0)
            Button("Reset") {
                hideKeyboard()
            }
        }
    }
    
}
