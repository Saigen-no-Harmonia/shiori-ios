//
//  Untitled.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/14.
//

import ComposableArchitecture
import UIKit

@DependencyClient
struct PhotoSaverClient {
  var savePhoto: @Sendable (URL) async throws -> Void
}

extension PhotoSaverClient: DependencyKey {
  static let liveValue = PhotoSaverClient(
    savePhoto: { url in
      let data = try Data(contentsOf: url)
      guard let image = UIImage(data: data) else {
        throw PhotoSaverError.invalidImage
      }
      
      try await withCheckedThrowingContinuation { continuation in
        let completion = UIImageWriteToSavedPhotosAlbumCompletion()
        completion.continuation = continuation
        
        UIImageWriteToSavedPhotosAlbum(
          image,
          completion,
          #selector(UIImageWriteToSavedPhotosAlbumCompletion.image(_:didFinishSavingWithError:contextInfo:)),
          nil
        )
      }
    }
  )
}

extension DependencyValues {
  var photoSaver: PhotoSaverClient {
    get { self[PhotoSaverClient.self] }
    set { self[PhotoSaverClient.self] = newValue }
  }
}

enum PhotoSaverError: Error {
  case invalidImage
}

private final class UIImageWriteToSavedPhotosAlbumCompletion: NSObject {
  var continuation: CheckedContinuation<Void, any Error>?

  @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error {
      continuation?.resume(throwing: error)
    } else {
      continuation?.resume()
    }
    continuation = nil
  }
}
