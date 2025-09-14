//
//  Access.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/03.
//

import Foundation

public struct Access: Decodable, Equatable, Sendable {
  let gatheringDate: Date
  let gatheringSpot: String
  let restaurantName: String
  let restaurantURL: URL
  let startingDate: Date
  let venueURL: URL
  let venueAddress: String
  let latitude: String
  let longitude: String

  enum CodingKeys: String, CodingKey {
    case gatheringDate
    case gatheringSpot
    case restaurantName
    case restaurantURL = "restaurantUrl"
    case startingDate
    case venueURL = "venueAccessPageUrl"
    case venueAddress
    case latitude
    case longitude
  }
}
