//
//  GreetingView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import ComposableArchitecture
import Kingfisher
import SwiftUI
import Utility

@Reducer
public struct GreetingStore: Sendable {
  @ObservableState
  public struct State: Equatable {
    var photoURL: URL?
    var greetingText: String?
  
    public init() {}
  }
  
  public enum Action {
    case onFirstAppear
    case greetingResponse(Result<GreetingResponse, Error>)
  }
  
  @Dependency(\.greetingRepository) var greetingRepository

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onFirstAppear:
        return .run { send in
          await send(.greetingResponse(Result {
            try await greetingRepository.getGreeting()
          }))
        }
      case let .greetingResponse(.success(response)):
        state.photoURL = response.photo.url
        state.greetingText = response.greeting.content
        return .none
      case .greetingResponse:
        return .none
      }
    }
  }
}

public struct GreetingView: View {
  let store: StoreOf<GreetingStore>

  public init(store: StoreOf<GreetingStore>) {
    self.store = store
  }

  public var body: some View {
    VStack(alignment: .center, spacing: 48) {
      ZStack(alignment: .bottom) {
        KFImage(store.photoURL)
          .aspectRatio(contentMode: .fit)
        LinearGradient(colors: [.clear, .white], startPoint: .top, endPoint: .bottom)
          .padding(.top, 350)
        LargeTitleBoldText("ごあいさつ")
      }
      .fixedSize()
      Title3Text(store.greetingText ?? "")
      Spacer()
    }
    .ignoresSafeArea()
    .onFirstAppear {
      store.send(.onFirstAppear)
    }
  }
}

#Preview {
  GreetingView(store: Store(initialState: GreetingStore.State()) {
    GreetingStore()
  })
}
