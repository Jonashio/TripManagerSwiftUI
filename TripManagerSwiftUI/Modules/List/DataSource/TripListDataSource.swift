//
//  TripListDataSource.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import Foundation

final class TripListDataSource  {
    
    private enum Keys {
        static let method: String = "api/trips"
        static let methodStops: String = "api/{stopId}"
    }
    
    private weak var operation: URLSessionDataTask?
    
    func fetchRequest(completion: @escaping NTResponse<TripListModel>) {
        cancelOperation()
        
        guard let request = URLRequest.buildRequest(method: "https://europe-west1-metropolis-fe-test.cloudfunctions.net/api/trips", methodType: .GET) else {
            completion(.error(.unknown))
            return
        }
        
        operation = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                completion(.error(.serverFailure(error)))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let model = try decoder.decode(TripListModel.self, from: data)
                
                completion(.success(model))
            } catch {
                completion(.error(.unknown))
            }
        }
        
        operation?.resume()
    }
    
    func fetchDetailRequest(params: NTParams, completion: @escaping NTResponse<StopExtensionModel>) {
        cancelOperation()
        guard let stopId = params["stopId"] else {
            completion(.error(.unknown))
            return
        }
        
        guard let request = URLRequest.buildRequest(method: "https://europe-west1-metropolis-fe-test.cloudfunctions.net/api/stops/{stopId}".replacingOccurrences(of: "{stopId}", with: stopId),
                                                    methodType: .GET) else {
            completion(.error(.unknown))
            return
        }
        
        operation = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                completion(.error(.serverFailure(error)))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let model = try decoder.decode(StopExtensionModel.self, from: data)
                
                completion(.success(model))
            } catch {
                completion(.error(.unknown))
            }
        }
        
        operation?.resume()
    }
    
    private func cancelOperation() {
        guard let operation = self.operation else { return }
        operation.cancel()
    }
}
