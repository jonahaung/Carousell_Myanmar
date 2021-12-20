//
//  PagnitionProgressView.swift
//  MyBike
//
//  Created by Aung Ko Min on 17/11/21.
//

import SwiftUI

struct PagnitionProgressView: View {

    var onAppear: (() -> Void)
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
            Spacer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                Vibration.rigid.vibrate()
                onAppear()
            }
        }
    }
}
