//
//  AccessView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import ComposableArchitecture
import MapKit
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
    var location: CLLocationCoordinate2D?

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
        state.location = response.toCLLocation()
        return .none
      case .accessResponse:
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
    NavigationStack {
      VStack {
        Grid {
          GridRow {
            HeadlineText("会場名")
            Title3BoldText(store.state.restaurantName)
          }
          GridRow {
            HeadlineText("住所")
            Title3BoldText(store.state.venueAddress)
          }
        }
        Map {
          if let coordinate = store.state.location {
            Marker("", coordinate: coordinate)
          }
        }
        .frame(height: 150)
        Grid {
          GridRow {
            HeadlineText("集合場所")
            Title3BoldText(store.state.gatheringSpot)
          }
          GridRow {
            HeadlineText("集合時間")
            Title3BoldText(store.state.gatheringDate)
          }
        }
        Button("詳細なアクセスはこちら") {}
      }
      .navigationTitle("アクセス")
      .toolbarBackground(.white, for: .navigationBar)
    }
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
