//
//  TripListViewModel.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import Foundation
import MapKit
import SwiftUI

final class TripListViewModel: NSObject, ObservableObject {
    
    private struct Constants {
        static let DefaultRegion = (latitude: 41.817927, longitude: 1.684978)
        static let delta = 1.5
    }
    
    private let dataSource = TripListDataSource()
    @Published var list = TripListModel()
    @Published var coordinateRegion: MKCoordinateRegion = .init(center: CLLocationCoordinate2D(latitude: Constants.DefaultRegion.latitude, longitude: Constants.DefaultRegion.longitude),span: .init(latitudeDelta: Constants.delta, longitudeDelta: Constants.delta))
    @Published var selectedIndex: Int?
    
    func fetch() {
        dataSource.fetchRequest() { response in
            switch response {
            case .success(let model):
                print("Jona pintamos el numero de elementos: \(model.count)")
                DispatchQueue.main.async {
                    withAnimation { self.list = model }
                    self.list = model
                }
            case .error(let error):
                print("ERROR")
            }
            
        }
    }
}
