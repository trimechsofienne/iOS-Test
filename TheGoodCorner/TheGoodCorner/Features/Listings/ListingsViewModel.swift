//
//  ListingsViewModel.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 05/05/2026.
//

import Foundation
import Combine

/// ViewModel for the listings screen.
///
/// Manages loading of listings and categories,
/// category-based filtering, and categoryId → name resolution.
/// All state mutations happen on the MainActor.
@MainActor
final class ListingsViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published private(set) var state: ViewState<[Listing]> = .idle
    @Published private(set) var categories: [Category] = []
    @Published var selectedCategory: Category?

    // MARK: - Private Properties

    private let repository: ListingRepositoryProtocol
    private var categoryMap: [Int: String] = [:]
    private var currentListings: [Listing] = []
    private var loadTask: Task<Void, Never>?

    /// Base URL for constructing full image URLs from relative paths.
    let baseURL: URL

    // MARK: - Init

    init(repository: ListingRepositoryProtocol, baseURL: URL) {
        self.repository = repository
        self.baseURL = baseURL
    }

    deinit {
        loadTask?.cancel()
    }

    // MARK: - Computed Properties

    /// Listings filtered by the selected category.
    var filteredListings: [Listing] {
        guard let selected = selectedCategory else {
            return currentListings
        }
        return currentListings.filter { $0.categoryId == selected.id }
    }

    // MARK: - Public Methods

    /// Returns the category name for a listing, or fallback if unknown.
    func categoryName(for listing: Listing) -> String {
        categoryMap[listing.categoryId] ?? L10n.unknownCategory
    }

    /// Loads all listings and categories in parallel.
    func load() {
        loadTask?.cancel()
        state = .loading

        loadTask = Task {
            do {
                async let feedTask = repository.fetchAllListings()
                async let categoriesTask = repository.fetchCategories()

                let feed = try await feedTask
                let fetchedCategories = try await categoriesTask

                guard !Task.isCancelled else { return }

                currentListings = feed.items
                categories = fetchedCategories
                categoryMap = Dictionary(
                    uniqueKeysWithValues: fetchedCategories.map { ($0.id, $0.name) }
                )
                state = .loaded(feed.items)
            } catch {
                guard !Task.isCancelled else { return }
                state = .error(error.localizedDescription)
            }
        }
    }

    /// Retries a failed load.
    func retry() {
        load()
    }

    /// Updates the category filter.
    func selectCategory(_ category: Category?) {
        selectedCategory = category
    }
}
