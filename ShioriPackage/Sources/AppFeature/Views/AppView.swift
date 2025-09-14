//
//  AppView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import ComposableArchitecture
import MainTabFeature
import SplashFeature
import SwiftUI
import Utility

@Reducer
public struct AppStore {
  @ObservableState
  public struct State {
    var isSplashCompleted: Bool = false
    public init() {}
  }

  public enum Action {
    case onFirstAppear
    case splashCompleted
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onFirstAppear:
        return .run { send in
          try await Task.sleep(for: .seconds(2))
          await send(.splashCompleted, animation: .easeInOut)
        }
      case .splashCompleted:
        state.isSplashCompleted = true
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
      SplashView()
        .opacity(store.state.isSplashCompleted ? 0 : 1)
        .animation(.easeInOut(duration: 0.5), value: store.state.isSplashCompleted)
    }
    .onFirstAppear {
      store.send(.onFirstAppear)
    }
  }
}

#Preview {
  AppView(store: Store(initialState: AppStore.State()) {
    AppStore()
  })
}
