//
//  TripListDataSource.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import Foundation

final class TripListDataSource: CommonDataSourceProtocol {
    func fetchRequest<T>(params: NTParams, completion: @escaping NTResponse<T>) where T : Decodable, T : Encodable {
        completion(.success(TripModel.init(status: nil, stops: nil, origin: nil, startTime: nil, tripModelDescription: nil, endTime: nil, route: nil, destination: nil, driverName: nil) as! T))
    }
    
    
}
