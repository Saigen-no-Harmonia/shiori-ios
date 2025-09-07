//
//  PhotoView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/05.
//

import ComposableArchitecture
import Kingfisher
import SwiftUI

@Reducer
public struct PhotoStore: Sendable {
  @ObservableState
  public struct State: Equatable {
    var sendOnDisappear = false
    var photo: GalleryPhoto

    public init(photo: GalleryPhoto) {
      self.photo = photo
    }
  }

  public enum Action: Sendable {
    case onDisappear
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onDisappear:
        return .none
      }
    }
  }
}

public struct PhotoView: View {
  @State var store: StoreOf<PhotoStore>
  @Environment(\.dismiss) var dismiss

  public init(store: StoreOf<PhotoStore>) {
    self.store = store
  }

  public var body: some View {
    KFImage(store.state.photo.url)
      .resizable()
      .scaledToFit()
      .onDisappear {
        if store.sendOnDisappear {
          store.send(.onDisappear)
        }
      }
  }
}

#Preview {
  PhotoView(store: Store(initialState: .init(photo: GalleryPhoto(id: "1", url: .init(string: "https://placeholder.com/150x150")!))) {
    PhotoStore()
  })
}
