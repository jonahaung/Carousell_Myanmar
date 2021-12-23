//
//  ActivityView.swift
//  MyBike
//
//  Created by Aung Ko Min on 23/12/21.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) private var presentationMode
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>){
        uiViewController.completionWithItemsHandler = { (_, _, _, _) in
            presentationMode.wrappedValue.dismiss()
        }
    }
}

