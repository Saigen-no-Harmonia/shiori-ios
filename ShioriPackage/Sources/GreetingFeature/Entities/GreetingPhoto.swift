//
//  GreetingPhoto.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/01.
//

import Foundation

struct GreetingPhoto: Decodable {
  let url: URL

  enum CodingKeys: String, CodingKey {
    case url = "photoUrl"
  }
}
