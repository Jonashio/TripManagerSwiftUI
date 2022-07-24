//
//  TripListViewModel.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import Foundation
import MapKit

final class TripListViewModel: NSObject, ObservableObject {
    @Published var coordinateRegion: MKCoordinateRegion = .init()
    
    func fetch(completion: @escaping NTResponse<Void> ) {
        
    }
}
