//
//  ViewRouter.swift
//  CustomTabBar
//
// Created by BLCKBIRDS
// Visit BLCKBIRDS.COM FOR MORE TUTORIALS

import SwiftUI

class ViewRouter: ObservableObject {
    enum Page {
        case home
        case messages
        case user
        case settings
    }

    @Published var currentPage: Page = .home
}
