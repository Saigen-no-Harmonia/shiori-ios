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
    var profiles: [Family] = []

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
        state.profiles = response.families
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
    VStack {
      if !store.state.profiles.isEmpty {
        PageView(store.state.profiles, id: \.id) { profile in
          Page("\(profile.name)家") {
            ScrollView {
              PresenterProfileView(profile: profile.presenter)
              Divider()
              Title3BoldText("家族")
              ForEach(profile.participants, id: \.id) { participant in
                ParticipantProfileView(profile: participant)
              }
              if let cats = profile.cats {
                ForEach(cats, id: \.id) { cat in
                  CatProfileView(profile: cat)
                }
              }
            }
          }
        }
        .selectedColor(Colors.primary.color)
        .menuHorizontalAlignment(.center)
        .indicatorColor(Colors.primary.color)
      } else {
        ContentUnavailableView("読み込み中...", image: "")
      }
    }
    .background(Colors.background.color)
    .toolbarBackground(Colors.background.color, for: .tabBar)
    .onFirstAppear {
      store.send(.onFirstAppear)
    }
  }
}

#Preview {
  ProfileView(store: Store(initialState: ProfileStore.State()) {
    ProfileStore()
  })
}
