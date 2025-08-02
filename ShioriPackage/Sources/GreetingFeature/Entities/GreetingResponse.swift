//
//  GreetingResponse.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/01.
//

import Foundation

public struct GreetingResponse: Decodable, Sendable {
  let greeting: Greeting
  let photo: GreetingPhoto

  enum CodingKeys: String, CodingKey {
    case greeting
    case photo = "topPhoto"
  }
}
