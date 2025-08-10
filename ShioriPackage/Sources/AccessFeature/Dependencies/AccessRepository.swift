//
//  AccessRepository.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/03.
//

import CoreLocation
import ComposableArchitecture
import Foundation

@DependencyClient
struct AccessRepository: Sendable {
  var getAccess: @Sendable () async throws -> Access
}

extension AccessRepository: DependencyKey {
  static let liveValue = Self(getAccess: { await mock })
  static let testValue = Self(getAccess: { await mock })
}

extension AccessRepository {
  @MainActor static let mock = Access(gatheringDate: Date.now,
                                      gatheringSpot: "皇居前",
                                      latitude: CLLocationDegrees(35.685175),
                                      longitude: CLLocationDegrees(139.7527995),
                                      restaurantName: "皇居レストラン KOKYO",
                                      restaurantURL: URL(string: "https://example/com")!,
                                      startingDate: Date.now,
                                      venueURL: URL(string: "https://example.com")!,
                                      venueAddress: "東京都千代田区千代田１−１")
}

extension DependencyValues {
  var accessRepository: AccessRepository {
    get { self[AccessRepository.self] }
    set { self[AccessRepository.self] = newValue }
  }
}
