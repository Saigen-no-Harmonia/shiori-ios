//
//  Family.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/01.
//

import Foundation
import Tagged

struct Family: Decodable, Equatable, Sendable {
  typealias ID = Tagged<Self, String>

  let id: ID
  let name: String
  let presenter: PresenterProfile
  let participants: [ParticipantProfile]
  let cats: [CatProfile]?

  enum CodingKeys: String, CodingKey {
    case id = "ieId"
    case name = "ieName"
    case presenter = "presenterProfile"
    case participants = "participantProfiles"
    case cats = "nekoProfiles"
  }
}
