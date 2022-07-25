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
    @Published var selectedIndex: Int?
    @Published var routesLocation: [CLLocationCoordinate2D] = []
    
    func generateRouteInMap(_ index: Int) {
        let trip = list[index]
        var locations = [CLLocationCoordinate2D]()
        
        guard let sourcePoint = buildCoordinate(trip.origin?.point), let destinationPoint = buildCoordinate(trip.destination?.point) else {
            // TODO: Pending show popup error
            return
        }
        
        locations.append(sourcePoint)
        trip.stops?.forEach({ stopPoint in
            if let point = buildCoordinate(stopPoint.point) {
                locations.append(point)
            } else {
                // TODO: Pending show popup error
                return
            }
        })
        locations.append(destinationPoint)
        
        print("Jonas en el generateRouteInMap generamos \(list[index].driverName) ---> \(locations)/\(trip.stops?.count)")
        self.routesLocation = locations
        
    }
    
    private func buildCoordinate(_ point: PointModel?) -> CLLocationCoordinate2D? {
        guard let lat = point?.latitude, let lon = point?.longitude else {
            return nil
        }
        
        return CLLocationCoordinate2DMake(lat, lon)
    }
    
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
