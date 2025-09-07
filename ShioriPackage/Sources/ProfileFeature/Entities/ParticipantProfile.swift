//
//  ParticipantProfile.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/01.
//

import Foundation
import Tagged

struct ParticipantProfile: Decodable, Equatable {
  typealias ID = Tagged<Self, String>

  let id: ID
  let birthDate: Date
  let birthPlace: String
  let firstName: String
  let firstNameKana: String
  let hobby: String
  let job: String
  let lastName: String
  let lastNameKana: String
  let likeFood: String
  let message: String
  let photoURL: URL
  let relation: String

  enum CodingKeys: String, CodingKey {
    case id
    case birthDate
    case birthPlace
    case firstName
    case firstNameKana
    case hobby
    case job
    case lastName
    case lastNameKana
    case likeFood
    case message
    case photoURL = "photoUrl"
    case relation
  }
}
