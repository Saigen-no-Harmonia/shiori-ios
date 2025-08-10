//
//  BundleClient.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/10.
//

import ComposableArchitecture
import Foundation

@DependencyClient
public struct BundleClient: Sendable {
  var shortVersionString: @Sendable () -> String = { "" }
}

extension BundleClient: DependencyKey {
  public static let liveValue: Self = .init(
    shortVersionString: {
      Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
  )
  
  public static let testValue = Self()
}

extension DependencyValues {
  var bundleClient: BundleClient {
    get { self[BundleClient.self] }
    set { self[BundleClient.self] = newValue }
  }
}
