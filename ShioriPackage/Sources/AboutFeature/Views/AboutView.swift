//
//  AboutView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import ComposableArchitecture
import SwiftUI
import Utility

@Reducer
public struct AboutStore: Sendable {
  @ObservableState
  public struct State {
    var version: String = ""

    public init() {}
  }
  
  public enum Action {
    case onFirstAppear
    case tapLicense
    case tapSourceCodeiOS
    case tapSourceCodeServer
    case browserOpenResponse
  }

  @Dependency(\.applicationClient) var applicationClient
  @Dependency(\.bundleClient) var bundleClient

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onFirstAppear:
        state.version = "v\(bundleClient.shortVersionString())"
        return .none
      case .tapLicense:
        return .run { send in
          let url = URL(string: UIApplication.openSettingsURLString)!
          guard await applicationClient.canOpenURL(url) else { return }
          _ = try await applicationClient.open(url)
          await send(.browserOpenResponse)
        }
      case .tapSourceCodeiOS:
        return .run { send in
          let url = URL(string: "https://github.com/Saigen-no-Harmonia/shiori-ios")!
          guard await applicationClient.canOpenURL(url) else { return }
          _ = try await applicationClient.open(url)
          await send(.browserOpenResponse)
        }
      case .tapSourceCodeServer:
        return .run { send in
          let url = URL(string: "https://github.com/Saigen-no-Harmonia/shiori-server")!
          guard await applicationClient.canOpenURL(url) else { return }
          _ = try await applicationClient.open(url)
          await send(.browserOpenResponse)
        }
      case .browserOpenResponse:
        return .none
      }
    }
  }
}

public struct AboutView: View {
  let store: StoreOf<AboutStore>

  public init(store: StoreOf<AboutStore>) {
    self.store = store
  }

  public var body: some View {
    NavigationStack {
      ZStack {
        Colors.background.color.ignoresSafeArea()
        VStack(alignment: .leading, spacing: 0) {
          TitleBoldText("アプリについて")
            .padding(.top, 40)
            .padding(.leading, 24)
          List {
            Section {
              HStack {
                BodyText("📕ライセンス情報")
                Spacer()
                Image(systemName: "chevron.right")
                  .frame(width: 18, height: 18)
                  .foregroundStyle(.gray)
              }
              .onTapGesture {
                store.send(.tapLicense)
              }
              HStack {
                BodyText("📱ソースコード (iOS)")
                Spacer()
                Image(systemName: "chevron.right")
                  .frame(width: 18, height: 18)
                  .foregroundStyle(.gray)
              }
              .onTapGesture {
                store.send(.tapSourceCodeiOS)
              }
              HStack {
                BodyText("💻ソースコード (サーバー)")
                Spacer()
                Image(systemName: "chevron.right")
                  .frame(width: 18, height: 18)
                  .foregroundStyle(.gray)
              }
              .onTapGesture {
                store.send(.tapSourceCodeServer)
              }
              HStack {
                BodyText("🏷️アプリバージョン")
                Spacer()
                BodyText(store.state.version)
              }
              HStack {
                BodyText("⚠️アプリの公開期間")
                Spacer()
                BodyText("2026年1月末まで")
              }
            }
            .listRowBackground(Colors.background.color)
          }
        }
      }
    }
    .scrollContentBackground(.hidden)
    .onFirstAppear {
      store.send(.onFirstAppear)
    }
  }
}

#Preview {
  AboutView(store: Store(initialState: AboutStore.State()) {
    AboutStore()
  })
}
