//
//  Access.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/03.
//

import CoreLocation
import Foundation

public struct Access: Decodable, Equatable, Sendable {
  let gatheringDate: Date
  let gatheringSpot: String
  let latitude: CLLocationDegrees
  let longitude: CLLocationDegrees
  let restaurantName: String
  let restaurantURL: URL
  let startingDate: Date
  let venueURL: URL
  let venueAddress: String

  enum CodingKeys: String, CodingKey {
    case gatheringDate
    case gatheringSpot
    case latitude
    case longitude
    case restaurantName
    case restaurantURL = "restaurantUrl"
    case startingDate
    case venueURL = "venueAccessUrl"
    case venueAddress
  }

  func toCLLocation() -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}
