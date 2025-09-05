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
  }
  
  @Dependency(\.accessRepository) var accessRepository
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
    VStack(alignment: .leading, spacing: 0) {
      if store.isLoading {
        ProgressView()
          .tint(Colors.primary.color)
      } else {
        VStack(alignment: .leading) {
          TitleBoldText("アクセス")
            .padding(.bottom, 24)
          Grid {
            GridRow {
              HeadlineText("会場名")
                .frame(width: 90)
              Title3BoldText(store.state.restaurantName)
            }
            .padding(.bottom, 24)
            GridRow {
              HeadlineText("住所")
              Title3BoldText(store.state.venueAddress)
            }
            .padding(.bottom, 24)
          }
          Grid {
            GridRow {
              HeadlineText("集合場所")
                .frame(width: 90)
              Title3BoldText(store.state.gatheringSpot)
            }
            .padding(.bottom, 24)
            GridRow {
              HeadlineText("集合時間")
              Title3BoldText(store.state.gatheringDate)
            }
            .padding(.bottom, 24)
          }
          Button("詳細なアクセスはこちら") {}
          Spacer()
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
