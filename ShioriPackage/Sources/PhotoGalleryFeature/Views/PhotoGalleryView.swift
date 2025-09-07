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
    let limit: Int = 20
    var photos: [GalleryPhoto] = []
    var offset: Int = 0
    var isAllLoaded: Bool = false

    public init() {}
  }
  
  public enum Action {
    case onFirstAppear
    case reachedLastPhoto
    case fetchPhotos
    case photoGalleryResponse(Result<GalleryPhotos, Error>)
    case photoTapped(GalleryPhoto)
  }
  
  @Dependency(\.photoGalleryRepository) var photoGalleryRepository

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onFirstAppear:
        return .run { send in
          await send(.fetchPhotos)
        }
      case .reachedLastPhoto:
        if state.isAllLoaded { return .none }
        return .run { send in
          await send(.fetchPhotos)
        }
      case .fetchPhotos:
        return .run { [limit = state.limit, offset = state.offset] send in
          await send(.photoGalleryResponse(Result {
            try await photoGalleryRepository.getGalleryPhotos(limit, offset)
          }))
        }
      case let .photoGalleryResponse(.success(response)):
        state.photos += response.galleryPhotos
        state.offset += response.galleryPhotos.count
        if response.galleryPhotos.isEmpty {
          state.isAllLoaded = true
        }
        return .none
      case .photoGalleryResponse:
        return .none
      case let .photoTapped(photo):
        return .none
      }
    }
  }
}

public struct PhotoGalleryView: View {
  @State var store: StoreOf<PhotoGalleryStore>
  
  public init(store: StoreOf<PhotoGalleryStore>) {
    self.store = store
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ScrollView {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
          ForEach(store.state.photos, id: \.id) { photo in
            KFImage(photo.url)
              .setProcessor(DownsamplingImageProcessor(size: CGSize(width: geometry.size.width, height: geometry.size.width)))
              .resizable()
              .scaledToFill()
              .frame(width: geometry.size.width / 2, height: geometry.size.width / 2)
              .clipped()
              .onAppear {
                if photo == store.state.photos.last {
                  store.send(.reachedLastPhoto)
                }
              }
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
