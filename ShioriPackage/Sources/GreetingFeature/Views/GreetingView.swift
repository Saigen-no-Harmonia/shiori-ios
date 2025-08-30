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
    var isLoading: Bool = false
  
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
        state.isLoading = true
        return .run { send in
          await send(.greetingResponse(Result {
            try await greetingRepository.getGreeting()
          }))
        }
      case let .greetingResponse(.success(response)):
        state.isLoading = false
        state.photoURL = response.photo.url
        state.greetingText = response.greeting.content
        return .none
      case .greetingResponse:
        state.isLoading = false
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
    GeometryReader { reader in
      if store.isLoading {
        ProgressView()
          .tint(Colors.primary.color)
          .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
      } else {
        ScrollView {
          VStack(alignment: .center) {
            ZStack(alignment: .bottom) {
              KFImage(store.photoURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: reader.size.width,
                       height: reader.size.height / 2)
                .clipped()
              LinearGradient(colors: [.clear, Colors.background.color], startPoint: .top, endPoint: .bottom)
              LargeTitleBoldText("ごあいさつ")
                .padding(.bottom, 24)
            }
            .frame(height: reader.size.height / 2)
            BodyText(store.greetingText ?? "")
              .multilineTextAlignment(.center)
              .padding(.horizontal, 24)
          }
        }
      }
    }
    .ignoresSafeArea(.all)
    .background(Colors.background.color)
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
