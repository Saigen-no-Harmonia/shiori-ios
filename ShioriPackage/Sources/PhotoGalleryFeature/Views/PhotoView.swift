//
//  PhotoView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/05.
//

import ComposableArchitecture
import SwiftUI
import Utility

@Reducer
public struct PhotoStore: Sendable {
  @ObservableState
  public struct State: Equatable {
    var photo: GalleryPhoto
    var isDownloadSucceeded: Bool?
    var sendOnDisappear = false

    public init(photo: GalleryPhoto) {
      self.photo = photo
    }
  }

  public enum Action: Sendable {
    case downloadButtonTapped
    case photoSaveCompleted(Result<Void, Error>)
    case toastComepleted
    case onDisappear
  }

  @Dependency(\.photoSaver) var photoSaver

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .downloadButtonTapped:
        return .run { [url = state.photo.url] send in
          await send(.photoSaveCompleted(Result {
            try await photoSaver.savePhoto(url)
          }))
        }
      case let .photoSaveCompleted(result):
        switch result {
        case .success:
          state.isDownloadSucceeded = true
          return .run { send in
            try await Task.sleep(for: .seconds(2))
            await send(.toastComepleted)
          }
        case .failure:
          state.isDownloadSucceeded = false
          return .run { send in
            try await Task.sleep(for: .seconds(2))
            await send(.toastComepleted)
          }
        }
      case .toastComepleted:
        state.isDownloadSucceeded = nil
        return .none
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
    ZStack {
      Color.black.ignoresSafeArea()
      ProgressView()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      PhotoViewer(imageURL: store.state.photo.url)
      Button {
        store.send(.downloadButtonTapped)
      } label: {
        VStack(alignment: .center) {
          Image(systemName: "square.and.arrow.down")
            .resizable()
            .scaledToFit()
            .tint(.white)
            .frame(width: 24, height: 24)
          CaptionText("保存する", color: .white)
        }
        .padding(.trailing, 12)
        .padding(.top, 24)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
      if let isDownloadSucceeded = store.isDownloadSucceeded {
        if isDownloadSucceeded {
          ToastView(message: "成功しました", image: "checkmark.circle.fill")
        } else {
          ToastView(message: "失敗しました", image: "xmark.circle.fill")
        }
      }
    }
    .animation(.easeInOut(duration: 0.5), value: store.isDownloadSucceeded)
    .onDisappear {
      if store.sendOnDisappear {
        store.send(.onDisappear)
      }
    }
  }
}

#Preview {
  PhotoView(store: Store(initialState: .init(photo: GalleryPhoto(id: "1", url: .init(string: "https://placehold.jp/150x150")!))) {
    PhotoStore()
  })
}
