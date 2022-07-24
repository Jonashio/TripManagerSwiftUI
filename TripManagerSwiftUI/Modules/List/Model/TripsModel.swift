//
//  TripsModel.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import Foundation
import SwiftUI

// MARK: - TripModelElement
struct TripModel: Codable {
    let id = UUID()
    let status: Status?
    let stops: [StopModel]?
    let origin: DestinationModel?
    let startTime, tripModelDescription, endTime, route: String?
    let destination: DestinationModel?
    let driverName: String?

    enum CodingKeys: String, CodingKey {
        case status, stops, origin, startTime
        case tripModelDescription = "description"
        case endTime, route, destination, driverName
    }
}

enum Status: String, Codable {
    case ongoing
    case cancelled
    case scheduled
    case finalized
}

// MARK: - Destination
struct DestinationModel: Codable {
    let address: String?
    let point: PointModel?
}

// MARK: - Point
struct PointModel: Codable {
    let latitude, longitude: Double?

    enum CodingKeys: String, CodingKey {
        case latitude = "_latitude"
        case longitude = "_longitude"
    }
}

// MARK: - Stop
struct StopModel: Codable {
    let point: PointModel?
    let id: Int?
}

typealias TripListModel = [TripModel]
