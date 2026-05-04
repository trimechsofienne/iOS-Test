//
//  AppCoordinator.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import SwiftUI
import Combine

/// Centralized navigation coordinator.
///
/// Manages the app's navigation state through a `NavigationPath`,
/// providing type-safe routing via the `Route` enum.
/// This pattern scales to multiple flows without modifying individual views.
@MainActor
final class AppCoordinator: ObservableObject {

    // MARK: - Route

    /// Type-safe representation of all navigation destinations.
    enum Route: Hashable {
        case detail(listing: Listing, categoryName: String)
    }

    // MARK: - Published Properties

    @Published var path = NavigationPath()

    // MARK: - Properties

    /// Base URL injected for image URL construction in destination views.
    let baseURL: URL

    // MARK: - Init

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    // MARK: - Navigation

    func showDetail(listing: Listing, categoryName: String) {
        path.append(Route.detail(listing: listing, categoryName: categoryName))
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
