//
//  GalleryPhoto.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/01.
//

import Foundation
import Tagged

struct GalleryPhoto: Decodable, Equatable {
  typealias ID = Tagged<Self, String>

  let id: ID
  let url: URL

  enum CodingKeys: String, CodingKey {
    case id
    case url = "photoUrl"
  }
}
