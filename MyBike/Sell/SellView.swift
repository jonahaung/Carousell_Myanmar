//
//  SellView.swift
//  MyBike
//
//  Created by Aung Ko Min on 20/10/21.
//

import SwiftUI
import MapKit

struct SellView: View {

    var presented: Binding<Bool>
    
    @State private var sellingItem = SellingItem()
    @FocusState private var focusedField: Field?
    @EnvironmentObject private var authenticationService: AuthenticationService
    @StateObject private var appAlertManager = AppAlertManager.shared
    @StateObject private var itemSeller = ItemSeller()

    var body: some View {
        ZStack(alignment: .bottom) {
            Form {
                SellImagesSection(sellingItem: $sellingItem)
                Section {
                    FormCell("Category") { Text(sellingItem.category.title)}
                    .tapToPush(CategoryPickerView(category: $sellingItem.category))
                    
                    FormCell("Title      ") { TextField("Polygon Siskiu D7 2022 M 29er", text: $sellingItem.title)}
                    .autocapitalization(.words)
                    .focused($focusedField, equals: .title)
                    
                    FormCell("Price      ") { TextField("$0000", text: $sellingItem.price)}
                    .keyboardType(.numbersAndPunctuation)
                    .focused($focusedField, equals: .price)
                }
                
                Section {
                    Picker("Condition", selection: $sellingItem.condition) {
                        ForEach(Item.Condition.allCases) {
                            
                            let elements = $0.uiElements()
                            
                            Label($0.description, systemImage: elements.iconName).foregroundColor(elements.color).tag($0)
                        }
                    }
                    .foregroundStyle(.secondary)
                    
                    Picker("Dealing Type", selection: $sellingItem.dealType) {
                        ForEach(Item.ExchangeType.allCases, id: \.self) {
                            Text($0.rawValue)
                                .foregroundColor(.accentColor)
                                .tag($0)
                        }
                    }
                    .foregroundStyle(.secondary)
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Description")
                            .foregroundColor(.secondary)
                        
                        TextEditor(text: $sellingItem.detailText)
                            .listRowSeparator(.hidden)
                            .focused($focusedField, equals: .description)
                    }
                }
                
                
                Section {
                    FormCell("State"){ SellAddressSection(address: $sellingItem.address)}
                    .tapToPush(regionPicker)
                    
                    FormCell("Phone Numnber") { TextField("Phone Number", text: .constant(""))}
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                    .focused($focusedField, equals: .phoneNumber)
                }
                
                Section{
                    
                }
            }
            submitButton
        }
        .navigationBarTitle("Sell")
        .navigationBarItems(leading: navBarLeadingView)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                toolBarContent
            }
        }
        .confirmationAlert($appAlertManager.alert)
    }
    
    private var regionPicker: some View {
        RegionPicker(address: sellingItem.address) {
            sellingItem.address = $0
        }
    }
    private var submitButton: some View {
        Group {
            if sellingItem.isValidated {
                Button {
                    hideKeyboard()
                    AppAlertManager.shared.alert = AlertObject(buttonText: "Publish this item", action: {
                        if let person = authenticationService.currentUserViewModel?.person {
                            itemSeller.publish(sellingItem: sellingItem, person: person) {
                                presented.wrappedValue = false
                            }
                        }
                    })
                } label: {
                    Text("Publish")
                        .formSubmitButtonStyle()
                        .padding(.horizontal)
                }
            }
        }
    }
    
    private var navBarLeadingView: some View {
        HStack {
            Button("Reset") {
                AppAlertManager.shared.onComfirm(buttonText: "Reset Anyway") {
                    withAnimation {
                        sellingItem.reset()
                    }
                }
            }
            .disabled(sellingItem.isEmpty)
        }
    }
    
    private var toolBarContent: some View {
        HStack {
            Spacer()
            Button("Done") {
                hideKeyboard()
            }
        }
    }
}

extension SellView {

    enum Field {
        case title, price, description, phoneNumber
    }
    
}
