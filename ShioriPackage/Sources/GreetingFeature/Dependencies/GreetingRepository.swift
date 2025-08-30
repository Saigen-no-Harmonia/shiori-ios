//
//  GreetingRepository.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/02.
//

import ComposableArchitecture
import Foundation
import Utility

@DependencyClient
struct GreetingRepository: Sendable {
  var getGreeting: @Sendable () async throws -> GreetingResponse
}

extension GreetingRepository: DependencyKey {
  static let liveValue = Self(getGreeting: {
    @Dependency(\.apiClient) var apiClient
    return try await apiClient.request(GreetingRequest())
  })
  static let testValue = Self(getGreeting: { await mock })
}

extension GreetingRepository {
  @MainActor static let mock = GreetingResponse(
    greeting: Greeting(content: "本日はおひがらもよく、云々。\n本日はおひがらもよく、云々。\n本日はおひがらもよく、云々。\n本日はおひがらもよく、云々。\n本日はおひがらもよく、云々。\n本日はおひがらもよく、云々。"),
    photo: GreetingPhoto(url: URL(string: "https://placehold.jp/500x500.png")!))
}

extension DependencyValues {
  var greetingRepository: GreetingRepository {
    get { self[GreetingRepository.self] }
    set { self[GreetingRepository.self] = newValue }
  }
}
