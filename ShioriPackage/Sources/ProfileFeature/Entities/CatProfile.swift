//
//  CatProfile.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/01.
//

import Foundation
import Tagged

struct CatProfile: Decodable, Equatable {
  typealias ID = Tagged<Self, String>

  let id: ID
  let age: Int
  let likeFood: String
  let name: String
  let photoURL: URL
  let temperament: String

  enum CodingKeys: String, CodingKey {
    case id
    case age
    case likeFood
    case name
    case photoURL = "photoUrl"
    case temperament
  }
}
