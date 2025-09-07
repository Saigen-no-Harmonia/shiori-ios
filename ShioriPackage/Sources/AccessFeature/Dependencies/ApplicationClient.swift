//
//  ApplicationClient.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/05.
//

import ComposableArchitecture
import UIKit

@DependencyClient
struct ApplicationClient: Sendable {
  var canOpenURL: @Sendable (URL) async -> Bool = { _ in false }
  var open: @Sendable (URL) async throws -> Bool
}

extension ApplicationClient: DependencyKey {
  static let liveValue: Self = .init(
    canOpenURL: { @MainActor in UIApplication.shared.canOpenURL($0) },
    open: { @MainActor in await UIApplication.shared.open($0) },
  )
  
  static let testValue: Self = .init()
}

extension DependencyValues {
  var applicationClient: ApplicationClient {
    get { self[ApplicationClient.self] }
    set { self[ApplicationClient.self] = newValue }
  }
}
