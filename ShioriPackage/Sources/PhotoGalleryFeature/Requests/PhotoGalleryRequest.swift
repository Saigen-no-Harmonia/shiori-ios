//
//  PhotoGalleryRequest.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/24.
//

import Foundation
import Utility

struct PhotoGalleryRequest: ShioriRequestProtocol {
  typealias Response = GalleryPhotos

  var queryItems: [URLQueryItem]?
  var method: HTTPMethod = .get
  var path: Endpoint = .photoGallery
  var headers: [String : String]? = nil
  var body: Data? = nil

  init(limit: Int, offset: Int) {
    self.queryItems = [
      .init(name: "limit", value: String(limit)),
      .init(name: "offset", value: String(offset))
    ]
  }
}
