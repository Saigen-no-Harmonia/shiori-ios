//
//  AccessView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import ComposableArchitecture
import ErrorFeature
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
    var access: Access?
    var error: ErrorStore.State?
    var isLoading: Bool = false

    public init() {}
  }
  
  public enum Action {
    case onFirstAppear
    case accessResponse(Result<Access, Error>)
    case accessButtonTapped
    case venueButtonTapped
    case restaurantButtonTapped
    case browserOpenResponse
    case error(ErrorStore.Action)
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
        state.access = response
        state.isLoading = false
        return .none
      case .accessResponse(.failure(_)):
        state.isLoading = false
        state.error = ErrorStore.State()
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
      case .venueButtonTapped:
        guard let latitude = state.access?.latitude,
              let longitude = state.access?.longitude else { return .none }
        let url: URL = URL(string:  "https://www.google.com/maps/place/\(latitude),\(longitude)/@\(latitude),\(longitude),18z/data")!
        return .run { send in
          guard await applicationClient.canOpenURL(url) else { return }
          _ = try await applicationClient.open(url)
          await send(.browserOpenResponse)
        }
      case .browserOpenResponse:
        return .none
      case .error(.reloadButtonTapped):
        state.error = nil
        state.isLoading = true
        return .run { send in
          await send(.accessResponse(Result {
            try await accessRepository.getAccess()
          }))
        }
      case .error:
        return .none
      }
    }
    .ifLet(\.error, action: \.error) {
      ErrorStore()
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
      if store.isLoading {
        ShioriProgressView()
      } else if let store = store.scope(state: \.error, action: \.error) {
        ErrorView(store: store)
      } else {
        VStack(alignment: .leading) {
          ScrollView {
            VStack(alignment: .leading, spacing: 24) {
              TitleBoldText("会場へのアクセス")
                .padding(.bottom, 12)
                .padding(.top, 32)
              GroupBox {
                VStack {
                  HStack {
                    Image(.ribbon)
                    HeadlineText("会場名")
                      .padding(.top, 2)
                    Image(.ribbon)
                  }
                  Divider()
                  .padding(.bottom, 6)
                  Title3BoldText(store.state.restaurantName)
                    .padding(.bottom, 12)
                  Button(action: {
                    store.send(.restaurantButtonTapped)
                  }, label: {
                    HStack(spacing: 2) {
                      BodyBoldText("会場ホームページ", color: .primary)
                      Image(systemName: "chevron.right")
                    }
                    .tint(Colors.primary.color)
                  })
                }
                .frame(maxWidth: .infinity)
              }
              .groupBoxStyle(AccessGroupBoxStyle())
              GroupBox {
                VStack {
                  HStack {
                    Image(.ribbon)
                    HeadlineText("会場住所")
                      .padding(.top, 2)
                    Image(.ribbon)
                  }
                  Divider()
                    .padding(.bottom, 6)
                  Title3BoldText(store.state.venueAddress)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 12)
                  Button(action: {
                    store.send(.venueButtonTapped)
                  }, label: {
                    HStack(spacing: 2) {
                      BodyBoldText("Google Mapで場所を確認する", color: .primary)
                      Image(systemName: "chevron.right")
                    }
                    .tint(Colors.primary.color)
                  })
                }
                .frame(maxWidth: .infinity)
              }
              .groupBoxStyle(AccessGroupBoxStyle())
              GroupBox {
                VStack {
                  HStack {
                    Image(.ribbon)
                    HeadlineText("集合場所")
                      .padding(.top, 2)
                    Image(.ribbon)
                  }
                  Divider()
                    .padding(.bottom, 6)
                  Title3BoldText(store.state.gatheringSpot)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 12)
                  Button(action: {
                    store.send(.accessButtonTapped)
                  }, label: {
                    HStack(spacing: 2) {
                      BodyBoldText("詳細なアクセスを確認する", color: .primary)
                      Image(systemName: "chevron.right")
                    }
                    .tint(Colors.primary.color)
                  })
                }
                .frame(maxWidth: .infinity)
              }
              .groupBoxStyle(AccessGroupBoxStyle())
              GroupBox {
                VStack {
                  HStack {
                    Image(.ribbon)
                    HeadlineText("集合時間")
                      .padding(.top, 2)
                    Image(.ribbon)
                  }
                  Divider()
                    .padding(.bottom, 6)
                  Title3BoldText(store.state.gatheringDate)
                    .padding(.bottom, 12)
                }
                .frame(maxWidth: .infinity)
              }
              .groupBoxStyle(AccessGroupBoxStyle())
              Spacer()
            }
            .padding(.all, 24)
          }
        }
      }
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
