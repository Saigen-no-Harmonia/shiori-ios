//
//  PhotoGalleryView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import ComposableArchitecture
import ErrorFeature
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
    var error: ErrorStore.State?
    var isLoading: Bool = false
    var isPagingError: Bool = false
    var isPagingLoading: Bool = false
    @Presents var sheet: PhotoStore.State?

    public init() {}
  }
  
  public enum Action {
    case onFirstAppear
    case reachedLastPhoto
    case fetchPhotos
    case photoGalleryResponse(Result<GalleryPhotos, Error>)
    case photoTapped(GalleryPhoto)
    case sheet(PresentationAction<PhotoStore.Action>)
    case error(ErrorStore.Action)
    case reloadButtonTapped
  }
  
  @Dependency(\.photoGalleryRepository) var photoGalleryRepository

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onFirstAppear:
        state.isLoading = true
        return .run { send in
          await send(.fetchPhotos)
        }
      case .reachedLastPhoto:
        if state.isAllLoaded { return .none }
        return .run { send in
          await send(.fetchPhotos)
        }
      case .fetchPhotos:
        if state.offset == 0 {
          state.isLoading = true
        } else {
          state.isPagingLoading = true
        }
        return .run { [limit = state.limit, offset = state.offset] send in
          await send(.photoGalleryResponse(Result {
            try await photoGalleryRepository.getGalleryPhotos(limit, offset)
          }))
        }
      case let .photoGalleryResponse(.success(response)):
        state.isLoading = false
        state.isPagingLoading = false
        state.photos += response.galleryPhotos
        state.offset += response.galleryPhotos.count
        if response.galleryPhotos.isEmpty {
          state.isAllLoaded = true
        }
        return .none
      case .photoGalleryResponse(.failure(_)):
        state.isLoading = false
        state.isPagingLoading = false
        if state.photos.isEmpty {
          state.error = ErrorStore.State()
        } else {
          state.isPagingError = true
        }
        return .none
      case .photoGalleryResponse:
        state.isLoading = false
        state.isPagingLoading = false
        return .none
      case let .photoTapped(photo):
        state.sheet = PhotoStore.State(photo: photo)
        return .none
      case .sheet:
        return .none
      case .error(.reloadButtonTapped):
        state.error = nil
        state.offset = 0
        state.photos = []
        state.isAllLoaded = false
        state.isLoading = true
        return .run { send in
          await send(.fetchPhotos)
        }
      case .error:
        return .none
      case .reloadButtonTapped:
        state.isPagingLoading = true
        state.isPagingError = false
        return .run { send in
          await send(.fetchPhotos)
        }
      }
    }
    .ifLet(\.$sheet, action: \.sheet) {
      PhotoStore()
    }
    .ifLet(\.error, action: \.error) {
      ErrorStore()
    }
  }
}

public struct PhotoGalleryView: View {
  @State var store: StoreOf<PhotoGalleryStore>
  
  public init(store: StoreOf<PhotoGalleryStore>) {
    self.store = store
  }
  
  public var body: some View {
    ZStack {
      if store.isLoading && store.state.photos.isEmpty {
        ShioriProgressView()
      } else if let errorStore = store.scope(state: \.error, action: \.error) {
        ErrorView(store: errorStore)
      } else {
        GeometryReader { geometry in
          ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 4) {
              ForEach(store.state.photos, id: \.id) { photo in
                KFImage(photo.url)
                  .placeholder {
                    ShioriProgressView()
                  }
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
                  .onTapGesture {
                    store.send(.photoTapped(photo))
                  }
              }
            }
            if store.isPagingError {
              VStack(alignment: .center) {
                BodyText("読み込みに失敗しました")
                Spacer()
                Button(action: {
                  store.send(.reloadButtonTapped)
                }, label: {
                  BodyBoldText("再読み込み", color: .white)
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(Colors.primary.color)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal, 24)
                })
                .frame(height: 60)
                .padding(.bottom, 24)
              }
            }
            if store.isPagingLoading {
              ShioriProgressView()
                .frame(height: 60)
                .padding(.bottom, 24)
            }
          }
        }
      }
    }
    .background(Colors.background.color)
    .sheet(item: $store.scope(state: \.sheet, action: \.sheet)) { store in
      PhotoView(store: store)
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
