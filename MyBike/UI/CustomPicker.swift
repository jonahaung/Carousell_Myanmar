//
//  CustomPicker.swift
//  MyBike
//
//  Created by Aung Ko Min on 25/12/21.
//

import SwiftUI


struct CustomPicker<T: UIElementRepresentable>: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    private var data: [T]
    private var selectedData: T
    private var onPick: ((T) -> Void)? = nil
    
    private var displayData: [T] {
        if searchText.isEmpty {
            return data
        }
        return data.filter{ $0.uiElements().title.contains(searchText) }
    }
    
    @State private var searchText = ""
    
    init(_ data: [T], _ selectedData: T, _ onPick: ((T) -> Void)?) {
        self.data = data
        self.selectedData = selectedData
        self.onPick = onPick
    }
    
    var body: some View {
        
        List(displayData) { item in
            
            let uiElements = item.uiElements()
            
            Button(action: {
               
                if let onPick = onPick {
                    onPick(item)
                }else {
                   
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                HStack {
                    Text(uiElements.title)
                    Spacer()
                    
                    Image(systemName: uiElements.iconName)
                        .foregroundColor(uiElements.color)
                }
            })
                .buttonStyle(.borderless)
                .disabled(item.id == selectedData.id )
        }
        .navigationBarTitle(selectedData.uiElements().title)
        .navigationBarTitle("Picker")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search")
        
    }
    
}
