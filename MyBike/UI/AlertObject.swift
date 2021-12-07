//
//  AlertObject.swift
//  MyBike
//
//  Created by Aung Ko Min on 16/11/21.
//

import SwiftUI

struct AlertObject: Identifiable {
    
    var id: String { return title }
    let title: String
    var message: String? = nil
    var action: (() -> Void)? = {}

}

extension Alert {
    init(alertObject: AlertObject) {
        self.init(title: Text(alertObject.title), message: Text(alertObject.message ?? ""), primaryButton: Alert.Button.default(Text("OK"), action: alertObject.action), secondaryButton: Alert.Button.cancel())
    }
}
