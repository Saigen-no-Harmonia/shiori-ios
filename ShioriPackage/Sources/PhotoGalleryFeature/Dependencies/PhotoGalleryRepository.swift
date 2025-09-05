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
  var getGalleryPhotos: @Sendable (_ limit: Int, _ offset: Int) async throws -> GalleryPhotos
}

extension PhotoGalleryRepository: DependencyKey {
  static let liveValue = Self(getGalleryPhotos: { limit, offset in
    @Dependency(\.apiClient) var apiClient
    return try await apiClient.request(PhotoGalleryRequest(limit: limit, offset: offset))
  })
  static let testValue = Self(getGalleryPhotos: { _, _ in await mock })
}

extension PhotoGalleryRepository {
    @MainActor private static let photos: [GalleryPhoto] = Array(0...19).map { i in
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
