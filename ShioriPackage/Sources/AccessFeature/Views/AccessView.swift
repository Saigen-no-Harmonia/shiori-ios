//
//  AccessView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import ComposableArchitecture
import SwiftUI
import Utility

@Reducer
public struct AccessStore: Sendable {
  @ObservableState
  public struct State {
    var gatheringSpot: String = ""
    var gatheringDate: String = ""
    var restaurantName: String = ""
    var restaurantURL: URL?
    var startingDate: String = ""
    var venueURL: URL?
    var venueAddress: String = ""
    var isLoading: Bool = false

    public init() {}
  }
  
  public enum Action {
    case onFirstAppear
    case accessResponse(Result<Access, Error>)
    case accessButtonTapped
    case restaurantButtonTapped
    case browserOpenResponse
  }
  
  @Dependency(\.accessRepository) var accessRepository
  @Dependency(\.applicationClient) var applicationClient
  @Dependency(\.openURL) var openURL

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onFirstAppear:
        state.isLoading = true
        return .run { send in
          await send(.accessResponse(Result {
            try await accessRepository.getAccess()
          }))
        }
      case let .accessResponse(.success(response)):
        state.gatheringDate = DateFormatter.yearMonthDayHourMinute.string(from: response.gatheringDate)
        state.startingDate = DateFormatter.yearMonthDayHourMinute.string(from: response.startingDate)
        state.gatheringSpot = response.gatheringSpot
        state.restaurantName = response.restaurantName
        state.restaurantURL = response.restaurantURL
        state.venueURL = response.venueURL
        state.venueAddress = response.venueAddress
        state.isLoading = false
        return .none
      case .accessResponse:
        state.isLoading = false
        return .none
      case .accessButtonTapped:
        return .run { [url = state.venueURL] send in
          guard let url,
                await applicationClient.canOpenURL(url) else { return }
          _ = try await applicationClient.open(url)
          await send(.browserOpenResponse)
        }
      case .restaurantButtonTapped:
        return .run { [url = state.restaurantURL] send in
          guard let url,
                await applicationClient.canOpenURL(url) else { return }
          _ = try await applicationClient.open(url)
          await send(.browserOpenResponse)
        }
      case .browserOpenResponse:
        return .none
      }
    }
  }
}

public struct AccessView: View {
  let store: StoreOf<AccessStore>

  public init(store: StoreOf<AccessStore>) {
    self.store = store
  }

  public var body: some View {
    ZStack {
      Colors.background.color
      VStack(alignment: .leading) {
        if store.isLoading {
          ProgressView()
            .tint(Colors.primary.color)
        } else {
          VStack(alignment: .leading) {
            TitleBoldText("会場へのアクセス")
              .padding(.bottom, 12)
            Divider()
              .padding(.bottom, 12)
            HeadlineText("会場名")
              .padding(.bottom, 6)
            Title3BoldText(store.state.restaurantName)
              .padding(.bottom, 12)
            Button(action: {
              store.send(.restaurantButtonTapped)
            }, label: {
              HStack(spacing: 2) {
                BodyText("会場ホームページ", color: .primary)
                Image(systemName: "chevron.right")
              }
              .tint(Colors.primary.color)
            })
            Divider()
              .padding(.bottom, 12)
            HeadlineText("会場住所")
              .padding(.bottom, 6)
            Title3BoldText(store.state.venueAddress)
              .padding(.bottom, 12)
            Divider()
              .padding(.bottom, 12)
            HeadlineText("集合場所")
              .padding(.bottom, 6)
            Title3BoldText(store.state.gatheringSpot)
              .padding(.bottom, 12)
            Button(action: {
              store.send(.accessButtonTapped)
            }, label: {
              HStack(spacing: 2) {
                BodyText("詳細なアクセスを確認する", color: .primary)
                Image(systemName: "chevron.right")
              }
              .tint(Colors.primary.color)
            })
            Divider()
              .padding(.bottom, 12)
            HeadlineText("集合時間")
              .padding(.bottom, 6)
            Title3BoldText(store.state.gatheringDate)
              .padding(.bottom, 12)
            Spacer()
          }
        }
      }
      .padding(.all, 24)
    }
    .background(Colors.background.color)
    .onFirstAppear {
      store.send(.onFirstAppear)
    }
  }
}

#Preview {
  AccessView(store: Store(initialState: AccessStore.State()) {
    AccessStore()
  })
}
