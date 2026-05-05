//
//  TheGoodCornerApp.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import SwiftUI

@main
struct TheGoodCornerApp: App {

    @StateObject private var coordinator = DIContainer.shared.makeCoordinator()

    var body: some Scene {
        WindowGroup {
            ListingsView(
                viewModel: DIContainer.shared.makeListingsViewModel(),
                coordinator: coordinator
            )
        }
    }
}
