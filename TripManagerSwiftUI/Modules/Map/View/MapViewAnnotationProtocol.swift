//
//  MapViewAnnotationProtocol.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 26/7/22.
//
import MapKit

protocol MapViewAnnotationProtocol {
    func didSelect(_ coordinate: CLLocationCoordinate2D?)
}
