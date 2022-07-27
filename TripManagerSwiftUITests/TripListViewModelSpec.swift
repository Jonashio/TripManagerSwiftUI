//
//  TripListViewModelSpec.swift
//  TripListViewModelSpec
//
//  Created by Jonashio on 24/7/22.
//

import XCTest
import Combine
@testable import TripManagerSwiftUI

class TripListViewModelSpec: XCTestCase {
    
    var viewModel: TripListViewModel!
    var mockDataSource: MockTripListDataSource!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp(){
       mockDataSource = MockTripListDataSource()
        viewModel = .init(dataSource: mockDataSource)
    }

    func testFetchListDataWithCorrectResponseSuccess() {
        let expectation = XCTestExpectation(description: "Load correctly item's list")
        XCTAssertEqual(viewModel.list.count, 0, "Count list is 0 when still to be fetch")
        
        viewModel.$list.dropFirst().sink { list in
            XCTAssertGreaterThan(list.count, 0, "Count list is greater that 0 after to be fetch")
            expectation.fulfill()
        }.store(in: &cancellables)
        viewModel.fetch()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchListDataWithErrorResponse() {
        let expectation = XCTestExpectation(description: "Send error state")
        
        viewModel.$stateEvents.dropFirst().sink { state in
            if state == .error {
                XCTAssertEqual(state, .error, "Detect an error during fetch")
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        
        mockDataSource.tripListModel = nil
        viewModel.fetch()

        wait(for: [expectation], timeout: 1)
    }
    
    func testStateToLoadingWhenFetching() {
        let expectation = XCTestExpectation(description: "Send error state")
        
        viewModel.$stateEvents.dropFirst().sink { state in
            XCTAssertEqual(state, .loading, "Detect that state change to Loading when launch Fetch()")
            expectation.fulfill()
        }.store(in: &cancellables)
        
        viewModel.fetch()

        wait(for: [expectation], timeout: 1)
    }
    
    
}
