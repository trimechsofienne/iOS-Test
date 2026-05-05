//
//  ListingsView.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 05/05/2026.
//

import SwiftUI

/// Main listing screen with category filter, loading/error/empty states.
///
/// Navigation uses `NavigationStack` driven by `AppCoordinator`.
/// Pull-to-refresh is supported via `.refreshable`.
struct ListingsView: View {

    // MARK: - Properties

    @StateObject var viewModel: ListingsViewModel
    @ObservedObject var coordinator: AppCoordinator

    // MARK: - Body

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            content
                .navigationTitle(L10n.listingsTitle)
                .task { viewModel.load() }
                .refreshable { viewModel.load() }
                .navigationDestination(for: AppCoordinator.Route.self) { route in
                    switch route {
                    case .detail(let listing, let categoryName):
                        DetailPlaceholderView(title: listing.title)
                    }
                }
        }
        .accessibilityIdentifier(AccessibilityIdentifiers.listingsScreen)
    }

    // MARK: - Subviews

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView(L10n.loading)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .accessibilityLabel(L10n.accessibilityLoading)
                .accessibilityIdentifier(AccessibilityIdentifiers.loadingIndicator)

        case .error(let message):
            ErrorStateView(message: message, onRetry: viewModel.retry)

        case .loaded:
            loadedContent
        }
    }

    private var loadedContent: some View {
        VStack(spacing: 0) {
            categoryFilterBar
            listContent
        }
    }

    private var categoryFilterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.s) {
                CategoryChipView(
                    title: L10n.allCategories,
                    isSelected: viewModel.selectedCategory == nil,
                    action: { viewModel.selectCategory(nil) }
                )

                ForEach(viewModel.categories) { category in
                    CategoryChipView(
                        title: category.name,
                        isSelected: viewModel.selectedCategory == category,
                        action: { viewModel.selectCategory(category) }
                    )
                }
            }
            .padding(.horizontal, Spacing.l)
            .padding(.vertical, Spacing.s)
            .fixedSize(horizontal: false, vertical: true)
        }
        .frame(height: Spacing.categoryBarHeight)
        .background(Color(.systemBackground))
        .accessibilityIdentifier(AccessibilityIdentifiers.categoryFilterBar)
    }

    @ViewBuilder
    private var listContent: some View {
        if viewModel.filteredListings.isEmpty {
            EmptyStateView(
                message: L10n.emptyCategory,
                systemImage: Icon.filterEmpty
            )
        } else {
            List(viewModel.filteredListings) { listing in
                Button(action: {
                    coordinator.showDetail(
                        listing: listing,
                        categoryName: viewModel.categoryName(for: listing)
                    )
                }) {
                    ListingRowView(
                        listing: listing,
                        categoryName: viewModel.categoryName(for: listing),
                        baseURL: viewModel.baseURL
                    )
                }
                .buttonStyle(.plain)
            }
            .listStyle(.plain)
        }
    }
}

// MARK: - Temporary Placeholder

/// Temporary placeholder until DetailView is implemented in a later commit.
private struct DetailPlaceholderView: View {
    let title: String

    var body: some View {
        Text(title)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}
