//
//  DIContainer.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Dependency injection container.
///
/// Assembles concrete implementations and provides factory methods
/// for ViewModels and the Coordinator. Views never access this
/// singleton directly — only the `@main` App entry point calls it.
final class DIContainer {

    // MARK: - Singleton

    static let shared = DIContainer()

    // MARK: - Properties

    let baseURL: URL

    private let apiClient: APIClientProtocol
    let repository: ListingRepositoryProtocol

    // MARK: - Init

    private init() {
        baseURL = AppConfiguration.baseURL
        apiClient = APIClient(baseURL: baseURL)
        repository = ListingRepository(client: apiClient)
    }

    // MARK: - Factories

    func makeCoordinator() -> AppCoordinator {
        AppCoordinator(baseURL: baseURL)
    }

    @MainActor
    func makeListingsViewModel() -> ListingsViewModel {
        ListingsViewModel(repository: repository, baseURL: baseURL)
    }
}
