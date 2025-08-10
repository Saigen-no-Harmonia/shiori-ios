//
//  AboutView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import ComposableArchitecture
import LicenseList
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
  }

  @Dependency(\.bundleClient) var bundleClient

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onFirstAppear:
        state.version = "v\(bundleClient.shortVersionString())"
        return .none
      }
    }
  }
}

public struct AboutView: View {
  let store: StoreOf<AboutStore>

  public init(store: StoreOf<AboutStore>) {
    self.store = store
    UITableView.appearance().backgroundColor = .orange
  }

  public var body: some View {
    NavigationStack {
      List {
        Section {
          NavigationLink {
            LicenseListView()
              .navigationTitle("ライセンス情報")
          } label: {
            HStack {
              Image(systemName: "licenseplate")
                .frame(width: 18, height: 18)
              BodyText("ライセンス情報")
            }
          }
          HStack {
            HStack {
              Image(systemName: "text.page")
                .frame(width: 18, height: 18)
              BodyText("ソースコード (iOS)")
            }
            Spacer()
            Text("")
          }
          HStack {
            HStack {
              Image(systemName: "text.page")
                .frame(width: 18, height: 18)
              BodyText("ソースコード (サーバー)")
            }
            Spacer()
            Text("")
          }
        }
        Section {
          HStack {
            HStack {
              Image(systemName: "tag.fill")
                .frame(width: 18, height: 18)
              BodyText("アプリバージョン")
            }
            Spacer()
            BodyText(store.state.version)
          }
        }
      }
      .navigationTitle("アプリについて")
    }
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
