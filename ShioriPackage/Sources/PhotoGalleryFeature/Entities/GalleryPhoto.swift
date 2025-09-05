//
//  GalleryPhoto.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/01.
//

import Foundation
import Tagged

public struct GalleryPhoto: Decodable, Equatable, Sendable {
  typealias ID = Tagged<Self, String>

  let id: ID
  let url: URL

  enum CodingKeys: String, CodingKey {
    case id
    case url = "photoUrl"
  }
}
