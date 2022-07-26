//
//  CustomMapView.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 26/7/22.
//

import MapKit

class CustomMapView: MKMapView, MKMapViewDelegate {
    var externalAnnotationDelegate: MapViewAnnotationProtocol?
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 5.0
        return renderer
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        externalAnnotationDelegate?.didSelect(view.annotation?.coordinate)
    }
}
