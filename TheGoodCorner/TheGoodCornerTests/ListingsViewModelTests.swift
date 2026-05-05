//
//  ListingsViewModelTests.swift
//  TheGoodCornerTests
//
//  Created by Sofienne Trimech on 05/05/2026.
//

import XCTest
import Combine
@testable import TheGoodCorner

@MainActor
final class ListingsViewModelTests: XCTestCase {

    // MARK: - Properties

    private var mockRepository: MockListingRepository!
    private var viewModel: ListingsViewModel!
    private var cancellables: Set<AnyCancellable>!
    private let baseURL = URL(string: "http://test.local")!

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        mockRepository = MockListingRepository()
        viewModel = ListingsViewModel(repository: mockRepository, baseURL: baseURL)
        cancellables = []
    }

    override func tearDown() {
        mockRepository = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_initialState_isIdle() {
        XCTAssertEqual(viewModel.state, .idle)
        XCTAssertTrue(viewModel.categories.isEmpty)
        XCTAssertNil(viewModel.selectedCategory)
        XCTAssertTrue(viewModel.filteredListings.isEmpty)
    }

    func test_load_success_updatesStateAndPopulatesData() async {
        let expectedListing = TestData.makeListing(id: 1, categoryId: 4)
        let expectedCategory = TestData.makeCategory(id: 4, name: "Maison")
        
        mockRepository.fetchAllListingsResult = .success(TestData.makeFeed(items: [expectedListing]))
        mockRepository.fetchCategoriesResult = .success([expectedCategory])

        // Trigger load
        viewModel.load()
        
        // Wait for tasks to complete
        try? await Task.sleep(nanoseconds: 50_000_000)

        XCTAssertEqual(viewModel.state, .loaded([expectedListing]))
        XCTAssertEqual(viewModel.categories, [expectedCategory])
        XCTAssertEqual(viewModel.filteredListings, [expectedListing])
        
        // Verify category name resolution
        XCTAssertEqual(viewModel.categoryName(for: expectedListing), "Maison")
    }

    func test_load_failure_updatesStateToError() async {
        mockRepository.fetchAllListingsResult = .failure(HTTPError.networkError("timeout"))
        mockRepository.fetchCategoriesResult = .success([])

        viewModel.load()
        
        try? await Task.sleep(nanoseconds: 50_000_000)

        XCTAssertEqual(viewModel.state, .error(String(localized: "error.network timeout")))
    }

    func test_selectCategory_filtersListings() async {
        let listingMaison = TestData.makeListing(id: 1, categoryId: 4)
        let listingAuto = TestData.makeListing(id: 2, categoryId: 2)
        let categoryMaison = TestData.makeCategory(id: 4, name: "Maison")
        let categoryAuto = TestData.makeCategory(id: 2, name: "Auto")
        
        mockRepository.fetchAllListingsResult = .success(TestData.makeFeed(items: [listingMaison, listingAuto]))
        mockRepository.fetchCategoriesResult = .success([categoryMaison, categoryAuto])

        viewModel.load()
        try? await Task.sleep(nanoseconds: 50_000_000)

        // Initially no category selected, should show all
        XCTAssertNil(viewModel.selectedCategory)
        XCTAssertEqual(viewModel.filteredListings.count, 2)

        // Select Maison
        viewModel.selectCategory(categoryMaison)
        XCTAssertEqual(viewModel.selectedCategory, categoryMaison)
        XCTAssertEqual(viewModel.filteredListings, [listingMaison])

        // Select Auto
        viewModel.selectCategory(categoryAuto)
        XCTAssertEqual(viewModel.filteredListings, [listingAuto])

        // Deselect (select nil)
        viewModel.selectCategory(nil)
        XCTAssertEqual(viewModel.filteredListings.count, 2)
    }

    func test_categoryName_returnsUnknownIfMissing() async {
        let listingUnknown = TestData.makeListing(id: 1, categoryId: 999)
        mockRepository.fetchAllListingsResult = .success(TestData.makeFeed(items: [listingUnknown]))
        mockRepository.fetchCategoriesResult = .success([TestData.makeCategory(id: 4, name: "Maison")])

        viewModel.load()
        try? await Task.sleep(nanoseconds: 50_000_000)

        XCTAssertEqual(viewModel.categoryName(for: listingUnknown), L10n.unknownCategory)
    }
}
