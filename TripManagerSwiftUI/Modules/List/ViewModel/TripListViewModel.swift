//
//  TripListViewModel.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import Foundation
import MapKit
import SwiftUI

enum StateEvents {
    case normal
    case loading
    case error
}

final class TripListViewModel: NSObject, ObservableObject {
    private let dataSource = TripListDataSource()
    
    @Published var stateEvents: StateEvents = .normal { didSet { objectWillChange.send() } }
    @Published var list = TripListModel()
    @Published var selectedIndex: Int?
    @Published var routesLocation: [CLLocationCoordinate2D] = []
    @Published var detailData = (name: "", time: "", type: "")
    @Published var needMapRefresh = false

    func generateRouteInMap(_ index: Int) {
        let trip = list[index]
        var locations = [CLLocationCoordinate2D]()
        selectedIndex = index
        
        guard let sourcePoint = buildCoordinate(trip.origin?.point), let destinationPoint = buildCoordinate(trip.destination?.point) else {
            DispatchQueue.main.async { withAnimation { self.stateEvents = .error }}
            return
        }
        
        locations.append(sourcePoint)
        trip.stops?.forEach({ stopPoint in
            if let point = buildCoordinate(stopPoint.point) {
                locations.append(point)
            } else {
                DispatchQueue.main.async { withAnimation { self.stateEvents = .error }}
                return
            }
        })
        locations.append(destinationPoint)
        
        needMapRefresh = true
        routesLocation = locations
    }
    
    private func buildCoordinate(_ point: PointModel?) -> CLLocationCoordinate2D? {
        guard let lat = point?.latitude, let lon = point?.longitude else {
            return nil
        }
        
        return CLLocationCoordinate2DMake(lat, lon)
    }
    
    func fetch() {
        stateEvents = .loading
        dataSource.fetchRequest() { response in
            switch response {
            case .success(let model):
                DispatchQueue.main.async {
                    withAnimation {
                        self.list = model
                        self.stateEvents = .normal
                    }
                }
            case .error(_):
                DispatchQueue.main.async { withAnimation { self.stateEvents = .error }}
            }
            
        }
    }
    
    func loadDetailView(_ indexStop: Int) {
        if routesLocation.count > 2 && ![0, routesLocation.count-1].contains(indexStop) {
            fetchDetail(indexStop) { model in
                guard let name = model.userName, let time = model.stopTime?.toStringDateWithFormatDefault()
                else { return }
                
                DispatchQueue.main.async {
                    withAnimation { self.detailData = (name: name, time: time, type: "Stop") }
                }
            }
        }else{
            let trip = list[selectedIndex ?? 0]
            guard let name = trip.driverName,
                  let time = indexStop == 0 ? trip.startTime?.toStringDateWithFormatDefault() : trip.endTime?.toStringDateWithFormatDefault() else { return }
            withAnimation { self.detailData = (name: name, time: time, type: indexStop == 0 ? "Start" : "End") }
        }
    }
    
    private func fetchDetail(_ indexStop: Int, completion: @escaping (StopExtensionModel)->Void) {
        stateEvents = .loading
        dataSource.fetchDetailRequest(params: ["stopId": "\(indexStop)"]) { response in
            switch response {
            case .success(let model):
                completion(model)
                DispatchQueue.main.async { withAnimation { self.stateEvents = .normal }}
            case .error(_):
                DispatchQueue.main.async { withAnimation { self.stateEvents = .error }}
            }
            
        }
    }
}
extension TripListViewModel {
    func getActionHiddenError() -> ()->Void {
        return {withAnimation { self.stateEvents = .normal}}
    }
}
