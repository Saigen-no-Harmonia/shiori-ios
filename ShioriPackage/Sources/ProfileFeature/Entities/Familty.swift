//
//  Familty.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/01.
//

import Foundation
import Tagged

struct Family: Decodable {
  typealias ID = Tagged<Self, String>

  let id: ID
  let name: String
  let presenter: PresenterProfile
  let participants: [ParticipantProfile]
  let nekos: [NekoProfile]?

  enum CodingKeys: String, CodingKey {
    case id = "ieId"
    case name = "ieName"
    case presenter = "presenterProfile"
    case participants = "participantProfiles"
    case nekos = "nekoProfiles"
  }
}
