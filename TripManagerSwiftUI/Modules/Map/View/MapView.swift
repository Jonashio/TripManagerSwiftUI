//
//  MapView.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 25/7/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var routesLocation: [CLLocationCoordinate2D]
    
    private let mapView = CustomMapView()
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> CustomMapView {
        mapView.delegate = mapView
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.817927, longitude: 1.684978),
                                        span: MKCoordinateSpan(latitudeDelta: 1.5, longitudeDelta: 1.5))
        mapView.setRegion(region, animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: CustomMapView, context: UIViewRepresentableContext<MapView>) {
        
        if !routesLocation.isEmpty {
            print("jonas modificamos el routesLocation \(routesLocation.count)")
            
            var poinsAnnotation = [MKPointAnnotation]()
            var placeMarks = [MKPlacemark]()
            var requests = [MKDirections.Request]()
            
            uiView.removeAnnotations(uiView.annotations)
            uiView.removeOverlays(uiView.overlays)
            
            routesLocation.forEach { point in
                let requestAnnotation = MKPointAnnotation()
                requestAnnotation.coordinate = point
                poinsAnnotation.append(requestAnnotation)
                uiView.addAnnotation(requestAnnotation)
            }
            routesLocation.forEach { point in
                placeMarks.append(MKPlacemark(coordinate: point))
            }
            
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

class CustomMapView: MKMapView, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 5.0
        return renderer
    }
}
