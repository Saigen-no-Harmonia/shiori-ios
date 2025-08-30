//
//  PhotoGalleryRepository.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/03.
//

import ComposableArchitecture
import Foundation

@DependencyClient
struct PhotoGalleryRepository: Sendable {
  var getGalleryPhotos: @Sendable () async throws -> GalleryPhotos
}

extension PhotoGalleryRepository: DependencyKey {
  static let liveValue = Self(getGalleryPhotos: {
    @Dependency(\.apiClient) var apiClient
    return try await apiClient.request(PhotoGalleryRequest())
  })
  static let testValue = Self(getGalleryPhotos: { await mock })
}

extension PhotoGalleryRepository {
  private static let photos: [GalleryPhoto] = Array(0...19).map { i in
    GalleryPhoto(id: .init(String(i)), url: URL(string: "https://placehold.jp/1920x1080.png")!)
  }
  
  @MainActor static let mock = GalleryPhotos(galleryPhotos: photos)
}

extension DependencyValues {
  var photoGalleryRepository: PhotoGalleryRepository {
    get { self[PhotoGalleryRepository.self] }
    set { self[PhotoGalleryRepository.self] = newValue }
  }
}
