//
//  AppView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import ComposableArchitecture
import MainTabFeature
import PublicationEndFeature
import SwiftUI
import Utility

@Reducer
public struct AppStore {
  @ObservableState
  public struct State: Equatable {
    var isPublicationEnded: Bool = false

    public init() {}
  }

  public enum Action {
    case onFirstAppear
  }

  @Dependency(\.date) var date

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onFirstAppear:
        var calendar = Calendar(identifier: .gregorian)
        if let timeZone = TimeZone(identifier: "Asia/Tokyo") {
          calendar.timeZone = timeZone
        }
        calendar.locale = Locale(identifier: "ja_JP")
        if let publicationEndDate = calendar.date(from: DateComponents(year: 2026, month: 2, day: 1, hour: 0, minute: 0, second: 0)),
           date.now > publicationEndDate {
          state.isPublicationEnded = true
        }
        return .none
      }
    }
  }
}

public struct AppView: View {
  let store: StoreOf<AppStore>

  public init (store: StoreOf<AppStore>) {
    self.store = store
  }

  public var body: some View {
    ZStack {
      MainTabView()
      if store.isPublicationEnded {
        PublicationEndView()
      }
    }
    .onFirstAppear {
      store.send(.onFirstAppear)
    }
  }
}

#Preview("PublicationEnded") {
  AppView(store: Store(initialState: AppStore.State()) {
    AppStore()
  } withDependencies: {
    var calendar = Calendar(identifier: .gregorian)
    if let timeZone = TimeZone(identifier: "Asia/Tokyo") {
      calendar.timeZone = timeZone
    }
    calendar.locale = Locale(identifier: "ja_JP")
    let date = calendar.date(from: DateComponents(year: 2026, month: 2, day: 1, hour: 0, minute: 0, second: 1))!
    $0.date = .constant(date)
  })
}
