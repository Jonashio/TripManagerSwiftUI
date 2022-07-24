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
    }
    
    private weak var operation: URLSessionDataTask?
    
    func fetchRequest(completion: @escaping NTResponse<TripListModel>) {
        cancelOperation()
        
        guard let request = URLRequest.buildRequest(method: Keys.method, methodType: .GET) else {
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
    
    private func cancelOperation() {
        guard let operation = self.operation else { return }
        operation.cancel()
    }
}
