//
//  PhotoGalleryView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import ComposableArchitecture
import Kingfisher
import SwiftUI
import Utility

@Reducer
public struct PhotoGalleryStore: Sendable {
  @ObservableState
  public struct State: Equatable {
    var photos: [GalleryPhoto] = []

    public init() {}
  }
  
  public enum Action {
    case onFirstAppear
    case photoGalleryResponse(Result<GalleryPhotos, Error>)
  }
  
  @Dependency(\.photoGalleryRepository) var photoGalleryRepository

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onFirstAppear:
        return .run { send in
          await send(.photoGalleryResponse(Result {
            try await photoGalleryRepository.getGalleryPhotos()
          }))
        }
      case let .photoGalleryResponse(.success(response)):
        state.photos = response.galleryPhotos
        return .none
      case .photoGalleryResponse:
        return .none
      }
    }
  }
}

public struct PhotoGalleryView: View {
  let store: StoreOf<PhotoGalleryStore>

  public init(store: StoreOf<PhotoGalleryStore>) {
    self.store = store
  }

  public var body: some View {
    GeometryReader { geometry in
      ScrollView {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
          ForEach(store.state.photos, id: \.id) { photo in
            KFImage(photo.url)
              .resizable()
              .scaledToFill()
              .frame(width: geometry.size.width / 2, height: geometry.size.width / 2)
              .clipped()
          }
        }
      }
      .background(Colors.background.color)
      .toolbarBackground(Colors.background.color, for: .tabBar)
    }
    .onFirstAppear {
      store.send(.onFirstAppear)
    }
  }
}

#Preview {
  PhotoGalleryView(store: Store(initialState: PhotoGalleryStore.State()) {
    PhotoGalleryStore()
  })
}
