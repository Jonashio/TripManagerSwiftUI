//
//  MockTripListDataSource.swift
//  TripManagerSwiftUITests
//
//  Created by Jonashio on 27/7/22.
//
@testable import TripManagerSwiftUI

final class MockTripListDataSource: TripListDataSourceProtocol {
    var tripListModel: TripListModel? = [TripModel(status: .ongoing, stops: [], origin: nil, startTime: nil, tripModelDescription: nil, endTime: nil, route: nil, destination: nil, driverName: nil)]
    var detailModel: StopExtensionModel? = StopExtensionModel(point: nil, userName: nil, address: nil, tripID: nil, price: nil, stopTime: nil, paid: nil)
    
    func fetchRequest(completion: @escaping NTResponse<TripListModel>) {
        guard let tripListModel = tripListModel else {
            completion(.error(.unknown))
            return
        }
        
        completion(.success(tripListModel))
    }
    
    func fetchDetailRequest(params: NTParams, completion: @escaping NTResponse<StopExtensionModel>) {
        guard let detailModel = detailModel else {
            completion(.error(.unknown))
            return
        }
        
        completion(.success(detailModel))
    }
    
    
}
