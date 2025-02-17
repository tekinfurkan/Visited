//
//  VisitedApp.swift
//  Visited
//
//  Created by Furkan Tekin on 13.02.2025.
//

import SwiftUI

@main
struct VisitedApp: App {
    @StateObject var viewModel = LocationViewModel()
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(viewModel)
        }
    }
}
