//
//  ErrorView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/07.
//

import ComposableArchitecture
import SwiftUI
import Utility

@Reducer
public struct ErrorStore: Sendable {
  @ObservableState
  public struct State: Equatable {
    public init() {}
  }

  public enum Action {
    case reloadButtonTapped
  }

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .reloadButtonTapped:
        return .none
      }
    }
  }
}

public struct ErrorView: View {
  let store: StoreOf<ErrorStore>

  public init(store: StoreOf<ErrorStore>) {
    self.store = store
  }

  public var body: some View {
    ZStack {
      Color(Colors.background.color)
        .ignoresSafeArea()
      VStack {
        Image(systemName: "exclamationmark.triangle")
          .resizable()
          .frame(width: 40, height: 40)
          .foregroundStyle(Colors.primary.color)
          .padding(.bottom, 12)
        Title3BoldText("エラーが発生しました")
          .padding(.bottom, 40)
          .padding(.horizontal, 24)
        Button(action: {
          store.send(.reloadButtonTapped)
        }, label: {
          BodyBoldText("再読み込み", color: .white)
            .frame(maxWidth: .infinity, minHeight: 48)
            .background(Colors.primary.color)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 24)
        })
      }
    }
  }
}

#Preview {
  ErrorView(store: Store(initialState: ErrorStore.State()) {
    ErrorStore()
  })
}
