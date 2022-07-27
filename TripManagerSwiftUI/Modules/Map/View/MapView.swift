//
//  MapView.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 25/7/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    private let mapView = CustomMapView()
    
    @Binding var routesLocation: [CLLocationCoordinate2D]
    @Binding var needRefresh: Bool
    
    var action: ((Int)->Void)?
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> CustomMapView {
        mapView.delegate = mapView
        mapView.externalAnnotationDelegate = self
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.817927, longitude: 1.684978),
                                        span: MKCoordinateSpan(latitudeDelta: 1.5, longitudeDelta: 1.5))
        mapView.setRegion(region, animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: CustomMapView, context: UIViewRepresentableContext<MapView>) {
        
        if !routesLocation.isEmpty && needRefresh {
            needRefresh.toggle()
            // stores
            var poinsAnnotation = [MKPointAnnotation]()
            var placeMarks = [MKPlacemark]()
            var requests = [MKDirections.Request]()
            
            // reset
            uiView.removeAnnotations(uiView.annotations)
            uiView.removeOverlays(uiView.overlays)
            
            // save pointAnnotation & put it in map & placemark
            routesLocation.forEach { point in
                let requestAnnotation = MKPointAnnotation()
                requestAnnotation.coordinate = point
                poinsAnnotation.append(requestAnnotation)
                uiView.addAnnotation(requestAnnotation)
                
                placeMarks.append(MKPlacemark(coordinate: point))
            }
            // saver direction
            for (index, element) in placeMarks.enumerated() {
                if index < (placeMarks.count - 1) {
                    let destinationPlacemark = placeMarks[index+1]
                    let directionRequest = MKDirections.Request()
                    directionRequest.source = MKMapItem(placemark: element)
                    directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
                    directionRequest.transportType = .automobile
                    requests.append(directionRequest)
                }
            }
            
            // calculate region
            if let pointFirst = routesLocation.first, let pointLast = routesLocation.last {
                let first = MKMapPoint(pointFirst)
                let last = MKMapPoint(pointLast)
                let mapRect = MKMapRect(x: fmin(first.x,last.x),
                                        y: fmin(first.y,last.y),
                                        width: fabs(first.x-last.x),
                                        height: fabs(first.y-last.y));
                
                if let distance = CLLocationDistance(exactly: 25000) {
                    let region = MKCoordinateRegion( center: MKCoordinateRegion(mapRect).center,
                                                     latitudinalMeters: distance,
                                                     longitudinalMeters: distance)
                    uiView.setRegion(uiView.regionThatFits(region), animated: true)
                }
            }
            
            // call to load route in map
            requests.forEach { request in
                let directions = MKDirections(request: request)
                directions.calculate { response, error in
                    guard let response = response else { return }

                    let route = response.routes[0]
                    uiView.addOverlay(route.polyline, level: .aboveRoads)
                }
            }
        }
    }
}
extension MapView: MapViewAnnotationProtocol{
    func didSelect(_ coordinate: CLLocationCoordinate2D?) {
        guard let coord = coordinate else { return }
        guard let firstIndex = routesLocation.firstIndex(where: { $0.latitude == coord.latitude && $0.longitude == coord.longitude }) else {
            return
        }
        action?(firstIndex)
    }
}
