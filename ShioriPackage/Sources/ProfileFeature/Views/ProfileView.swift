//
//  ProfileView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import ComposableArchitecture
import Kingfisher
import Parchment
import SwiftUI
import Utility

@Reducer
public struct ProfileStore: Sendable {
  @ObservableState
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    case onFirstAppear
    case profileResponse(Result<Families, Error>)
  }
  
  @Dependency(\.profileRepository) var profileRepository

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onFirstAppear:
        return .run { send in
          await send(.profileResponse(Result {
            try await profileRepository.getProfile()
          }))
        }
      case let .profileResponse(.success(response)):
        return .none
      case .profileResponse:
        return .none
      }
    }
  }
}

public struct ProfileView: View {
  let store: StoreOf<ProfileStore>

  public init(store: StoreOf<ProfileStore>) {
    self.store = store
  }

  public var body: some View {
    PageView {
      Page("ほげ家") {
        Text("Page 0")
      }
      Page("ふが家") {
        Text("Page 1")
      }
    }
  }
}

#Preview {
  ProfileView(store: Store(initialState: ProfileStore.State()) {
    ProfileStore()
  })
}
